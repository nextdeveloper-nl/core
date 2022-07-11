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
use PlusClouds\Core\Database\Models\Discountable;
use PlusClouds\Core\Http\Requests\DiscountableStoreRequest;
use PlusClouds\Core\Http\Requests\DiscountStoreRequest;
use PlusClouds\Core\Http\Requests\DiscountUpdateRequest;

/**
 * Class DiscountController.
 *
 * @package PlusClouds\Core\Http\Controllers
 */
class DiscountController extends AbstractController {
    /**
     * @name Returns the Discount List
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
     * @name Returns details of a Discount
     *
     * @param Discount $discount
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Discount $discount) {
        return $this->withItem($discount, app('PlusClouds\Core\Http\Transformers\DiscountTransformer'));
    }

    /**
     * @name Creates a new Discount
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
     * @name Update a Discount
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
     * @name Delete a Discount
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

	/**
	 * @name Attach a Discount
	 *
	 * @param DiscountableStoreRequest $request
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 * @throws \PlusClouds\Core\Exceptions\ObjectNotFoundException
	 */
    public function attach(DiscountableStoreRequest $request) {

        $data = $request->validated();

        $classArr = findObjectFromClassName($data['object'],$data['object_id'],'Discountable');

        if(empty($classArr)){

            logger()->error('[Discount|Attach] Object Not Found');

            throw new \Exception('Object Not Found');
        }

        $discount = Discount::findByRef($data['discount_id']);

        Discountable::create([
            'discountable_id'     => $classArr[1],
            'discountable_type'   => $classArr[0],
            'discount_id'         => $discount->id,
        ]);

        return $this->noContent();
    }

	/**
	 * @name Detach a Discount
	 *
	 * @param DiscountableStoreRequest $request
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 * @throws \PlusClouds\Core\Exceptions\ObjectNotFoundException
	 */
    public function detach(DiscountableStoreRequest $request) {
        $data = $request->validated();

        $classArr = findObjectFromClassName($data['object'],$data['object_id'],'Discountable');

        Discountable::where([['discount_id',$data['discount_id']],['discountable_id',$classArr[1]],['discountable_type',$classArr[0]]])->delete();

        return $this->noContent();
    }
}
