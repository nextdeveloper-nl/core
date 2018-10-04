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


use BenSampo\Enum\Rules\EnumValue;
use PlusClouds\Core\Common\Enums\HookBehavior;
use PlusClouds\Core\Common\Enums\HookMethod;

/**
 * Class HookStoreRequest
 * @package PlusClouds\Core\Http\Requests
 */
class HookStoreRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can( 'core.hook@store' );
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'action'      => 'required|max:255',
            'behavior'    => [ 'required', new EnumValue( HookBehavior::class ) ],
            'url'         => 'required|url',
            'method'      => [ 'required', new EnumValue( HookMethod::class ) ],
            'parameters'  => 'array|nullable',
            'position'    => 'integer',
            'account_ref' => 'exists:accounts,id_ref',
        ];
    }

}