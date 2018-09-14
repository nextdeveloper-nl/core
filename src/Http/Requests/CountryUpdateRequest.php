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
 * Class CountryUpdateRequest
 * @package PlusClouds\Core\Http\Requests
 */
class CountryUpdateRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can( 'core.country@update' );
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'code'           => 'required|exists:countries,code',
            'locale'         => 'required',
            'name'           => 'required',
            'currency_code'  => 'required',
            'phone_code'     => 'required|integer',
            'percentage'     => 'required|digits_between:0,100',
            'rate'           => 'required_with:rate|numeric|between:0,99.99',
            'continent_name' => 'string|nullable',
            'continent_code' => 'required_with:continent_name|string|nullable',
        ];
    }

}