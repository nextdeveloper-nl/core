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


use PlusClouds\Core\Database\Models\Discount;

/**
 * Class DiscountTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class DiscountTransformer extends AbstractTransformer
{

    /**
     * @param Discount $discount
     *
     * @return array
     */
    public function transform(Discount $discount) {
        return $this->buildPayload( [
            'id'              => $discount->id_ref,
            'title'           => $discount->title,
            'min_order_value' => $discount->min_order_value,
            'percentage'      => $this->when( $discount->discount_type == false, $discount->percentage ),
            'currency_code'   => $this->when( $discount->discount_type == true, $discount->currency_code ),
            'price'           => $this->when( $discount->discount_type == true, $discount->price ),
            'start_at'        => $this->when( ! is_null( $discount->start_at ), optional( $discount->start_at )->toIso8601String() ),
            'expires_at'      => $this->when( ! is_null( $discount->start_at ), optional( $discount->expires_at )->toIso8601String() ),
        ] );
    }

}