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
 * Class TagUpdateRequest
 * @package PlusClouds\Core\Http\Requests
 */
class TagUpdateRequest extends AbstractFormRequest
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
            'name'        => 'required|max:50',
            'description' => 'nullable|max:500',
        ];
    }

}