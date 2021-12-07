<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Requests\Config;

use PlusClouds\Core\Http\Requests\AbstractFormRequest;

/**
 * Class CategoryStoreRequest.
 *
 * @package PlusClouds\Core\Http\Requests
 */
class ConfigStoreRequest extends AbstractFormRequest
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
            'key'       =>  'required|string|max:255',
            'value'     =>  'required',
            'object'    =>  'required|string',
            'object_id' =>  'required|string',
        ];
    }
}