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
 * Class HookUpdateRequest
 * @package PlusClouds\Core\Http\Requests
 */
class HookUpdateRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can( 'hook@update' )
            && getMasterAccount( $this->user() )->id == $this->route( 'hook' )->vendor_id;
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'action'     => 'required|max:255',
            'behavior'   => 'required|in:before,after',
            'url'        => 'required|url',
            'method'     => 'required|in:GET,POST,PUT,PATCH,DELETE',
            'parameters' => 'array|nullable',
            'position'   => 'integer',
        ];
    }

}