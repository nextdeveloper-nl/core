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

use PlusClouds\Core\Database\Filters\CategoryQueryFilter;
use PlusClouds\Core\Database\Models\Category;
use PlusClouds\Core\Database\Models\Domain;
use PlusClouds\Core\Exceptions\DuplicateModelFoundException;
use PlusClouds\Core\Http\Requests\CategoryStoreRequest;
use PlusClouds\Core\Http\Requests\CategoryUpdateRequest;

/**
 * Class CategoryController.
 *
 * @package PlusClouds\Core\Http\Controllers
 */
class CategoryController extends AbstractController {
    /**
     * Kategori listesini döndürür.
     *
     * @param CategoryQueryFilter $filter
     *
     * @throws \Throwable
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(CategoryQueryFilter $filter) {
        $categories = Category::filter($filter)->orderBy('order', 'ASC')->get();

        throw_if($categories->isEmpty(), 'Illuminate\Database\Eloquent\ModelNotFoundException', 'Could not find the categories you are looking for.');

        return $this->withCollection($categories->toTree(), app('PlusClouds\Core\Http\Transformers\CategoryTransformer'));
    }

    /**
     * Kategori bilgisini döndürür.
     *
     * @param Category $category
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Category $category) {
        return $this->withItem($category, app('PlusClouds\Core\Http\Transformers\CategoryTransformer'));
    }

    /**
     * Yeni bir kategori oluşturur.
     *
     * @param CategoryStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(CategoryStoreRequest $request) {
        $data = collect($request->validated())
            ->merge([
                'user_id'=> getAUUser()->id,
            ])
            ->when($request->filled('domain'), function ($collection) use ($request) {
                return $collection->put('domain_id', Domain::findByRef($request->get('domain'))->id);
            })
            ->forget(['domain', 'category']);

        $category = Category::create($data->toArray());

        // Seçilen kategorinin alt kategorisi olarak ekliyoruz.
        if ($request->get('category')) {
            $ancestor = Category::findByRef($request->get('category'));
            $ancestor->appendNode($category);
        }

        return $this->setStatusCode(201)
            ->withItem($category->fresh(), app('PlusClouds\Core\Http\Transformers\CategoryTransformer'));
    }

    /**
     * Varolan kategori bilgilerini günceller.
     *
     * @param CategoryUpdateRequest $request
     * @param Category              $category
     *
     * @return mixed
     */
    public function update(CategoryUpdateRequest $request, Category $category) {
        $data = collect($request->validated())
            ->when($request->filled('domain'), function ($collection) use ($request) {
                return $collection->put('domain_id', Domain::findByRef($request->get('domain'))->id);
            })
            ->filter(function ($value, $key) {
                return isset($value);
            })
            ->forget(['domain', 'category']);

	    $slugCheck = Category::where('slug', $request->get('slug'))->first();

	    throw_if($slugCheck, DuplicateModelFoundException::class, 'We have a category with this slug in our database. Please change the slug.');

        $category->update($data->toArray());

        if ($request->filled('category')) {
            $ancestor = Category::findByRef(($categoryRef = $request->get('category')));

            if ($ancestor->id_ref !== $categoryRef) {
                $category->appendToNode($ancestor)->save();
            }
        }

	    return $this->setStatusCode(201)
		    ->withItem($category->fresh(), app('PlusClouds\Core\Http\Transformers\CategoryTransformer'));
    }

    /**
     * Varolan bir kategoriyi siler.
     *
     * @param Category $category
     *
     * @throws \Exception
     *
     * @return mixed
     */
    public function destroy(Category $category) {
        $this->authorize('categoryDestroy', $category);

        $category->delete();

        return $this->noContent();
    }
}
