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

use PlusClouds\Account\Database\Models\Account;
use PlusClouds\Core\Database\Models\Country;
use PlusClouds\Core\Database\Models\Discount;
use PlusClouds\Core\Http\Requests\DiscountStoreRequest;
use PlusClouds\Core\Http\Requests\DiscountUpdateRequest;

/**
 * Class DiscountController.
 *
 * @package PlusClouds\Core\Http\Controllers
 */
class DiscountController extends AbstractController {
    /**
     * İndirim listesini döndürür.
     *
     * @throws \Throwable
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index() {
        $discounts = Discount::all();

        throw_if($discounts->isEmpty(), 'Illuminate\Database\Eloquent\ModelNotFoundException', 'Could not find discount records you are looking for.');

        return $this->withCollection($discounts, app('PlusClouds\Core\Http\Transformers\DiscountTransformer'));
    }

    /**
     * İndirim bilgisini döndürür.
     *
     * @param Discount $discount
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Discount $discount) {
        return $this->withItem($discount, app('PlusClouds\Core\Http\Transformers\DiscountTransformer'));
    }

    /**
     * Yeni bir indirim oluşturur.
     *
     * @param DiscountStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(DiscountStoreRequest $request) {
        $data = collect($request->validated())
            ->when($request->filled('account'), function ($collection) use ($request) {
                return $collection->put('account_id', Account::findByRef($request->get('account'))->id);
            })
            ->when($request->filled('country_code'), function ($collection) use ($request) {
                return $collection->put('country_id', Country::where('code', $request->get('country_code'))->firstOrFail()->id);
            })
            ->forget(['account', 'country_code']);

        $discount = Discount::create($data->toArray());

        return $this->setStatusCode(201)
            ->withItem($discount->fresh(), app('PlusClouds\Core\Http\Transformers\DiscountTransformer'));
    }

    /**
     * Varolan indirim bilgilerini günceller.
     *
     * @param DiscountUpdateRequest $request
     * @param Discount              $discount
     *
     * @return mixed
     */
    public function update(DiscountUpdateRequest $request, Discount $discount) {
        $data = collect($request->validated())
            ->when($request->filled('account'), function ($collection) use ($request) {
                return $collection->put('account_id', Account::findByRef($request->get('account'))->id);
            })
            ->when($request->filled('country_code'), function ($collection) use ($request) {
                return $collection->put('country_id', Country::where('code', $request->get('country_code'))->firstOrFail()->id);
            })
            ->filter(function ($value) {
                return ! is_null($value);
            })
            ->forget(['account', 'country_code']);

        $discount->update($data->toArray());

        return $this->noContent();
    }

    /**
     * Varolan bir indirimi siler.
     *
     * @param Discount $discount
     *
     * @throws \Exception
     *
     * @return mixed
     */
    public function delete(Discount $discount) {
        $this->authorize('destroy', $discount);

        $discount->delete();

        return $this->noContent();
    }
}
