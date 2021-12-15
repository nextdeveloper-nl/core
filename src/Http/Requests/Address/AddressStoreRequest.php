<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Requests\Address;

use PlusClouds\Core\Http\Requests\AbstractFormRequest;

/**
 * Class AddressStoreRequest.
 *
 * @package PlusClouds\Core\Http\Requests
 */
class AddressStoreRequest extends AbstractFormRequest
{
    /**
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * @return array
     */
    public function rules()
    {
        return [
            'name'                =>  'required|string|max:255',
            'line1'               =>  'string',
            'line2'               =>  'string',
            'city'                =>  'string',
            'state'               =>  'string',
            'state_code'          =>  'numeric',
            'postcode'            =>  'numeric',
            'is_invoice_address'  =>  'boolean',
            'country_id'          =>  'required|exists:countries,id_ref',
            'email_address'       =>  'email',
            'object'              =>  'required|string',
            'object_id'           =>  'required|string',
        ];
    }
}