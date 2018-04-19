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
use PlusClouds\Core\Database\Filters\CategoryQueryFilter;
use PlusClouds\Core\Database\Models\Category;
use PlusClouds\Core\Database\Models\Domain;
use PlusClouds\Core\Http\Requests\CategoryStoreRequest;
use PlusClouds\Core\Http\Requests\CategoryUpdateRequest;
use PlusClouds\Core\Http\Resources\CategoryCollection;
use PlusClouds\Core\Http\Resources\CategoryResource;

/**
 * Class CategoryController
 * @package PlusClouds\Core\Http\Controllers
 */
class CategoryController extends AbstractController
{

    /**
     * Kategori listesini döndürür.
     *
     * @param CategoryQueryFilter $filter
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index(CategoryQueryFilter $filter) {
        $categories = Category::filter( $filter )->get();

        throw_if( $categories->isEmpty(), ModelNotFoundException::class, 'Could not find the records you are looking for.' );

        return $this->withCollection( CategoryCollection::make( $categories ) );
    }

    /**
     * Kategori bilgisini döndürür.
     *
     * @param Category $category
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Category $category) {
        return $this->withItem( CategoryResource::make( $category ) );
    }


    /**
     * // Yeni bir kategori oluşturur.
     *
     * @param CategoryStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(CategoryStoreRequest $request) {
        $category = Category::create( array_merge( [ 'user_id' => $this->authUser->id ], $request->validated() ) );

        // Seçilen kategorinin alt kategorisi olarak ekliyoruz.
        if( $request->has( 'category_ref' ) ) {
            $ancestor = Category::findByRef( $request->get( 'category_ref' ) );
            $ancestor->appendNode( $category );
        }

        return $this->setStatusCode( 201 )
            ->withItem( CategoryResource::make( $category->fresh() ) );
    }


    /**
     * Varolan kategori bilgilerini günceller.
     *
     * @param CategoryUpdateRequest $request
     * @param Category $category
     *
     * @return mixed
     */
    public function update(CategoryUpdateRequest $request, Category $category) {
        $domain = Domain::findByRef( $request->get( 'domain_ref' ) );

        $category->update( [
            'name'        => $request->get( 'name' ),
            'description' => $request->get( 'description' ),
            'domain_id'   => $domain,
        ] );

        if( $request->has( 'category_ref' ) ) {
            $ancestor = Category::findByRef( ( $categoryRef = $request->get( 'category_ref' ) ) );

            if( $ancestor->id_ref !== $categoryRef ) {
                $category->makeChildOf( $ancestor );
            }
        }

        return $this->noContent();
    }


    /**
     * Varolan bir kategoriyi siler.
     *
     * @param Category $category
     *
     * @return mixed
     * @throws \Exception
     */
    public function destroy(Category $category) {
        $category->delete();

        // todo: Gate gelecek

        return $this->noContent();
    }

}