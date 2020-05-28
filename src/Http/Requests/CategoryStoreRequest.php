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
 * Class CategoryStoreRequest.
 *
 * @package PlusClouds\Core\Http\Requests
 */
class CategoryStoreRequest extends AbstractFormRequest {
    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can('core.category@store');
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'category'     => 'nullable|exists:categories,id_ref',
            'domain'       => 'required|exists:domains,id_ref',
            'name'         => 'required|max:255',
            'description'  => 'required|max:1500',
        ];
    }
}
