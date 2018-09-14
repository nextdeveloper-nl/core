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
 * Class DomainUpdateRequest
 * @package PlusClouds\Core\Http\Requests
 */
class DomainUpdateRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can( 'core.domain@update' )
            && getMasterAccount( $this->user() )->id == $this->route( 'domain' )->account_id;
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'name' => 'required|exists:domain,name,'.$this->route( 'domain' )->id,
        ];
    }

}