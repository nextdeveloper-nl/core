<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Requests\State;


use BenSampo\Enum\Rules\EnumValue;
use PlusClouds\Core\Http\Requests\AbstractFormRequest;

/**
 * Class StateStoreRequest
 * @package PlusClouds\Core\Http\Requests
 */
class StateUpdateRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return true;
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'state_name'   => 'required|string',
            'state_value'  => 'required',
            'state_reason' => 'string',
        ];
    }

}