<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Transformers;

use League\Fractal\ParamBag;
use PlusClouds\Account\Http\Transformers\AccountTransformer;
use PlusClouds\Core\Database\Models\Discount;

/**
 * Class DiscountTransformer.
 *
 * @package PlusClouds\Core\Http\Transformers
 */
class DiscountTransformer extends AbstractTransformer {
    /**
     * @var array
     */
    protected $availableIncludes = ['account', 'country'];

    /**
     * @param Discount $discount
     *
     * @return array
     */
    public function transform(Discount $discount) {
        return $this->buildPayload([
            'id'              => $discount->id_ref,
            'title'           => $discount->title,
            'min_order_value' => $discount->min_order_value,
            'percentage'      => $this->when(false == $discount->discount_type, $discount->percentage),
            'currency_code'   => $this->when(true == $discount->discount_type, $discount->currency_code),
            'price'           => $this->when(true == $discount->discount_type, $discount->price),
            'start_at'        => $this->when( ! is_null($discount->start_at), optional($discount->start_at)->toIso8601String()),
            'expires_at'      => $this->when( ! is_null($discount->start_at), optional($discount->expires_at)->toIso8601String()),
        ]);
    }

    /**
     * @param Discount      $discount
     * @param null|ParamBag $paramBag
     *
     * @throws \Exception
     *
     * @return \League\Fractal\Resource\Item
     */
    public function includeAccount(Discount $discount, ParamBag $paramBag = null) {
        if ( ! is_null($discount->account)) {
            return $this->item($discount->account, new AccountTransformer($paramBag));
        }
    }

    /**
     * @param Discount      $discount
     * @param null|ParamBag $paramBag
     *
     * @throws \Exception
     *
     * @return \League\Fractal\Resource\Item
     */
    public function includeCountry(Discount $discount, ParamBag $paramBag = null) {
        if ( ! is_null($discount->country)) {
            return $this->item($discount->country, new CountryTransformer($paramBag));
        }
    }
}
