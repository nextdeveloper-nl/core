<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Controllers;


use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use PlusClouds\Core\Database\Filters\TagQueryFilter;
use PlusClouds\Core\Database\Models\Tag;
use PlusClouds\Core\Database\Models\Taggables;
use PlusClouds\Core\Exceptions\UnauthorizedException;
use PlusClouds\Core\Http\Requests\TagAttachRequest;
use PlusClouds\Core\Http\Requests\TagDetachRequest;
use PlusClouds\Core\Http\Transformers\TagTransformer;
use PlusClouds\Core\Http\Requests\TagStoreRequest;
use PlusClouds\Core\Common\Enums\TagType;

/**
 * Class TagController
 * @package PlusClouds\Core\Http\Controllers
 */
class TagController extends AbstractController
{

    /**
     * Returns the tag list
     *
     * @param TagQueryFilter $filter
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index(TagQueryFilter $filter) {
        $tags = Tag::where( 'type', '!=', TagType::APPLICATION )->filter( $filter );

        if( isLoggedIn() )
            $tags = $tags->where('account_id', getAUCurrentAccount()->id);

        $tags = $tags->get();

        throw_if( $tags->isEmpty(), ModelNotFoundException::class, 'Could not find the tags you are looking for.' );

        return $this->withCollection( $tags, app( TagTransformer::class ) );
    }

    /**
     * @param TagStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws UnauthorizedException
     */
    public function store(TagStoreRequest $request) {
        if( ! getAUUser()->hasRole( [ 'super-admin', 'admin' ] ) ) {
            if( in_array( $request->get( 'type' ), [ TagType::SYSTEM, TagType::COMMON ] ) ) {
                throw new UnauthorizedException( 'You are not authorized to do this.' );
            }
        }

        $data = collect( $request->validated() );

        $data->when( in_array( $data->get( 'type' ), [ TagType::APPLICATION, TagType::USER ] ), function($collection) {
            return $collection->put( 'account_id', getAUCurrentAccount()->id );
        }, function($collection) {
            return $collection->put( 'account_id', null );
        } )->filter();

        $tag = Tag::firstOrCreate( $data->except( 'description' )->toArray() );

        if( $data->has( 'description' ) ) {
            $tag->update( $data->only( 'description' )->toArray() );
        }

        return $this->setStatusCode( 201 )
            ->withItem( $tag->fresh(), app( TagTransformer::class ) );
    }

    /**
     * Varolan bir etiketi siler.
     *
     * @param Tag $tag
     *
     * @return mixed
     * @throws \Exception
     */
    public function destroy(Tag $tag) {
        $this->authorize( 'tagDestroy', $tag );

        $tag->delete();

        return $this->noContent();
    }

    /**
     * Returns the list of applications
     *
     * @param TagQueryFilter $filter
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function applications(TagQueryFilter $filter) {
        $tags = Tag::where( 'type', TagType::APPLICATION )->filter( $filter );

        if( isLoggedIn() )
            $tags = $tags->where('account_id', getAUCurrentAccount()->id);

        $tags = $tags->get();

        throw_if( $tags->isEmpty(), ModelNotFoundException::class, 'Could not find application tags you are looking for.' );

        return $this->withCollection( $tags, app( TagTransformer::class ) );
    }

    public function attach(TagAttachRequest $request) {

        $data = $request->validated();

        $classArr = $this->findObjectFromClassName($data['object'],$data['object_id']);

        if(empty($classArr)){

            logger()->error('[Tag|Attach] Object Not Found');

            throw new \Exception('Object Not Found');
        }

        $tag = Tag::firstOrCreate(['name' => $data['tag']]);

	    Taggables::create([
           'taggable_type' => $classArr[0],
           'taggable_id'   => $classArr[1],
           'tag_id'        => $tag->id,
        ]);

        return $this->noContent();
    }

    public function detach(TagDetachRequest $request) {
        $data = $request->validated();

        $classArr = $this->findObjectFromClassName($data['object'],$data['object_id']);

        $tag = Tag::find($data['tag_id']);

        Taggables::where([['tag_id',$tag->id],['taggable_id',$classArr[1]],['taggable_type',$classArr[0]]])->delete();

        return $this->noContent();
    }

    private function findObjectFromClassName($object,$objectId):array{

        //composer dosyasına erişiyoruz
        $content = file_get_contents('../composer.json');

        //composer dosyasını okuyoruz
        $loadedLibs = array_keys(json_decode($content,true)['require']);

        foreach ($loadedLibs as $pckName){

            //require edilen plusclouds paketlerini buluyoruz
            if (substr($pckName,0,4) === 'plus'){

                //bulunan pakette adını alıyoruz
                $moduleName = ucfirst(explode('/',$pckName)[1]);

                //sonra bu paketin olabilecek pathini ayarlıyoruz
                $path = sprintf('PlusClouds\%s\Database\Models\%s',$moduleName,dashesToCamelCase($object,true));

                //ayarladığımız path gerçekten var moı diye bakıyoruz
                if (class_exists($path)){

                    $class = new $path();

                    //ayaraldığımız path var ise ve bu path taggable ise ilgili modeli buluyoruz
                    if (array_key_exists('PlusClouds\Core\Database\Traits\Taggable',class_uses_recursive($class))){

                        $objectId =  $class->findByRef($objectId)->id;

                        $object = $path;

                        return [$object,$objectId];

                    }else{

                        logger()->error('[Tag|Attach] attaching failed because provided object not available for this action');

                        throw new \Exception('Provided object not available for this action');

                    }
                }
            }
        }

       return [];
    }

}