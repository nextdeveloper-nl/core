<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Requests\Initiators;

use PlusClouds\Core\Http\Requests\AbstractFormRequest;

/**
 * Class CategoryStoreRequest.
 *
 * @package PlusClouds\Core\Http\Requests
 */
class InitiatorExecutionRequest extends AbstractFormRequest
{
    /**
     * @return bool
     */
    public function authorize()
    {
		return true;
        //return $this->user()->can('core.category@store');
    }

    /**
     * @return array
     */
    public function rules()
    {
        return [
            'module_name' =>  'required|string',
            'initiator'   =>  'required|string',
        ];
    }
}