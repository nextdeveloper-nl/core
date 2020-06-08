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
 * Class DiscountAddRequest.
 *
 * @package PlusClouds\Core\Http\Requests
 */
class DiscountAddRequest extends AbstractFormRequest {
    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can('core.discount@store');
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'start_at'   => 'nullable|date|date_format:Y-m-d h:i:s',
            'expires_at' => 'nullable|date|date_format:Y-m-d h:i:s',
        ];
    }
}
