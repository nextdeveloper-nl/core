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
 * Class HookStoreRequest
 * @package PlusClouds\Core\Http\Requests
 */
class HookStoreRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can( 'hook@store' );
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'action'      => 'required|max:255',
            'behavior'    => 'required|in:before,after',
            'url'         => 'required|url',
            'method'      => 'required|in:GET,POST,PUT,PATCH,DELETE',
            'parameters'  => 'array|nullable',
            'position'    => 'integer',
            'account_ref' => 'exists:accounts,id_ref',
        ];
    }

}