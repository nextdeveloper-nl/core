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
use PlusClouds\Core\Exceptions\UnauthorizedException;
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
     * Etiket listesini döndürür.
     *
     * @param TagQueryFilter $filter
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index(TagQueryFilter $filter) {
        if( isLoggedIn() ) {
            $tags = getAUCurrentAccount()->tags()->where( 'tags.type', TagType::APPLICATION )->get();
        } else {
            $tags = Tag::where( 'type', '!=', TagType::APPLICATION )->filter( $filter )->get();
        }

        throw_if( $tags->isEmpty(), ModelNotFoundException::class, 'Could not find the records you are looking for.' );

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

        dd($request);

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

}