<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Resources;


/**
 * Class DiscountResource
 * @package PlusClouds\Core\Http\Resources
 */
class DiscountResource extends AbstractResource
{

    /**
     * @param \Illuminate\Http\Request $request
     *
     * @return array
     */
    public function toArray($request) {
        return $this->filterFields( [
            'id'              => $this->id_ref,
            'title'           => $this->title,
            'type'            => $this->discount_type,
            'percentage'      => $this->when( $this->discount_type == 0, $this->percentage ),
            'price'           => $this->when( $this->discount_type == 1, $this->price ),
            'currency_code'   => $this->when( $this->discount_type == 1, $this->currency_code ),
            'min_order_value' => $this->when( $this->min_order_value > 0, $this->min_order_value ),
            'start_at'        => $this->when( ! is_null( $this->start_at ), optional( $this->start_at )->toIso8601String() ),
            'expires_at'      => $this->when( ! is_null( $this->expires_at ), optional( $this->expires_at )->toIso8601String() ),
        ] );
    }

}