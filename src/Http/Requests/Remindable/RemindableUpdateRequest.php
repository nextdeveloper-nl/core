<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Requests\Remindable;

use PlusClouds\Core\Http\Requests\AbstractFormRequest;

/**
 * Class RemindableUpdateRequest.
 *
 * @package PlusClouds\Core\Http\Requests
 */
class RemindableUpdateRequest extends AbstractFormRequest
{
    /**
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * @return array
     */
    public function rules()
    {
        return [
            'note'             => 'string',
            'snooze_datetime'  => 'string',
            'is_acknowledge'   => 'boolean',
        ];
    }
}