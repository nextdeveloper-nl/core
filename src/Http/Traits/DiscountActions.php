<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Traits;

use Illuminate\Database\Eloquent\Model;
use PlusClouds\Account\Database\Models\Account;
use PlusClouds\Core\Database\Models\Country;
use PlusClouds\Core\Database\Models\Discount;
use PlusClouds\Core\Http\Requests\DiscountAddRequest;
use PlusClouds\Core\Http\Requests\DiscountStoreRequest;

trait DiscountActions {
    public function getDiscountableModel() {
    }

    public function getDiscountableObjectTransformer() {
    }

    /**
     * @throws \Throwable
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function discountList(Model $discountableModel) {
        $discounts = $discountableModel->discounts;

        throw_if($discounts->count() <= 0, 'Illuminate\Database\Eloquent\ModelNotFoundException', 'Could not find the discount or discounts.');

        return $this->withCollection($discounts, app('PlusClouds\Core\Http\Transformers\DiscountTransformer'));
    }

    /**
     * @param DiscountStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function createDiscount(Model $discountableModel, DiscountStoreRequest $request) {
        $data = collect($request->validated())
            ->when($request->filled('account'), function ($collection) use ($request) {
                return $collection->put('account_id', Account::findByRef($request->get('account'))->id);
            })
            ->when($request->filled('country_code'), function ($collection) use ($request) {
                return $collection->put('country_id', Country::where('code', $request->get('country_code'))->firstOrFail()->id);
            })
            ->forget(['account', 'country_code']);

        $discountableObject = $discountableModel->createDiscount($data->toArray());

        return $this->setStatusCode(201)
            ->withItem($discountableObject, app($this->getDiscountableObjectTransformer()));
    }

    /**
     * @param DiscountAddRequest $request
     * @param Model              $discountableModel
     * @param Discount           $discount
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function addDiscount(DiscountAddRequest $request, Model $discountableModel, Discount $discount) {
        $data = collect($request->validated())
            ->keyBy(function ($value, $key) {
                return 'custom_'.$key;
            });

        $discountableObject = $discountableModel->addDiscount($discount, $data->toArray());

        return $this->setStatusCode(201)
            ->withItem($discountableObject, app($this->getDiscountableObjectTransformer()));
    }

    /**
     * @param Model    $discountableModel
     * @param Discount $discount
     *
     * @throws \Illuminate\Auth\Access\AuthorizationException
     *
     * @return mixed
     */
    public function destroyDiscount(Model $discountableModel, Discount $discount) {
        $this->authorize('discountDestroy', $discount);

        $discountableModel->deleteDiscount($discount);

        return $this->noContent();
    }
}
