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
use PlusClouds\Core\Database\Models\Tag;
use PlusClouds\Core\Http\Transformers\TagTransformer;

/**
 * Class TagController
 * @package PlusClouds\Core\Http\Controllers
 */
class TagController extends AbstractController
{

    /**
     * Etiket listesini döndürür.
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index() {
        $tags = Tag::all();

        throw_if( $tags->isEmpty(), ModelNotFoundException::class, 'Could not find the records you are looking for.' );

        return $this->withCollection( $tags, app( TagTransformer::class ) );
    }

    /**
     * Etiket bilgisini döndürür.
     *
     * @param Tag $tag
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Tag $tag) {
        return $this->withItem( $tag, app( TagTransformer::class ) );
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
        $tag->delete();

        // @todo: Gate gelecek

        return $this->noContent();
    }

}