<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Requests;


/**
 * Class DiscountStoreRequest
 * @package PlusClouds\Core\Http\Requests
 */
class DiscountStoreRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can( 'core.discount@store' );
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'title'           => 'required|max:255',
            'discount_type'   => 'required|numeric',
            'percentage'      => 'required_if:discount_type,0',
            'price'           => 'required_if:discount_type,1|regex:/^\d*(\.\d{1,4})?$/',
            'currency_code'   => 'required_with:price|exists:languages,currency_code',
            'min_order_value' => 'regex:/^\d*(\.\d{1,4})?$/',
            'start_at'        => 'date|date_format:Y-m-d h:i:s',
            'expires_at'      => 'date|date_format:Y-m-d h:i:s',
        ];
    }

}