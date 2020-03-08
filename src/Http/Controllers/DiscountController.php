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
use PlusClouds\Core\Database\Models\Discount;
use PlusClouds\Core\Http\Requests\DiscountStoreRequest;
use PlusClouds\Core\Http\Requests\DiscountUpdateRequest;
use PlusClouds\Core\Http\Transformers\DiscountTransformer;

/**
 * Class DiscountController
 * @package PlusClouds\Core\Http\Controllers
 */
class DiscountController extends AbstractController
{

    /**
     * İndirim listesini döndürür.
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index() {
        $discounts = Discount::all();

        throw_if( $discounts->isEmpty(), ModelNotFoundException::class, 'Could not find discount records you are looking for.' );

        return $this->withCollection( $discounts, app( DiscountTransformer::class ) );
    }

    /**
     * İndirim bilgisini döndürür.
     *
     * @param Discount $discount
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Discount $discount) {
        return $this->withItem( $discount, app( DiscountTransformer::class ) );
    }

    /**
     * Yeni bir indirim oluşturur.
     *
     * @param DiscountStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(DiscountStoreRequest $request) {
        $discount = Discount::create( $request->validated() );

        return $this->setStatusCode( 201 )
            ->withItem( $discount->fresh(), app( DiscountTransformer::class ) );
    }

    /**
     * Varolan indirim bilgilerini günceller.
     *
     * @param DiscountUpdateRequest $request
     * @param Discount $discount
     *
     * @return mixed
     */
    public function update(DiscountUpdateRequest $request, Discount $discount) {
        $discount->update( $request->validated() );

        return $this->noContent();
    }

    /**
     * Varolan bir indirimi siler.
     *
     * @param Discount $discount
     *
     * @return mixed
     * @throws \Exception
     */
    public function delete(Discount $discount) {
        $this->authorize( 'destroy', $discount );

        $discount->delete();

        return $this->noContent();
    }

}