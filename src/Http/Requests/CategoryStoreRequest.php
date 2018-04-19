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
 * Class CategoryStoreRequest
 * @package PlusClouds\Core\Http\Requests
 */
class CategoryStoreRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can( 'category@store' );
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'category_ref' => 'exists:categories,id_ref',
            'domain_ref'   => 'required|exists:domains,id_ref',
            'name'         => 'required',
            'description'  => 'required',
        ];
    }

}