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
 * Class CategoryUpdateRequest.
 *
 * @package PlusClouds\Core\Http\Requests
 */
class CategoryUpdateRequest extends AbstractFormRequest {
    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can('core.category@update')
            && $this->user()->id == $this->route('category')->user_id;
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'category'     => 'nullable|exists:categories,id_ref',
            'domain'       => 'nullable|exists:domains,id_ref',
            'name'          =>  'required|string|max:255',
            'url'           =>  'url',
            'description'   =>  'required|string|max:1500',
	        'order'         =>  'integer'
        ];
    }
}
