<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Requests\ServiceRole;


use PlusClouds\Core\Http\Requests\AbstractFormRequest;

/**
 * Class TagUpdateRequest
 * @package PlusClouds\Core\Http\Requests
 */
class ServiceRoleServiceCallbackRequest extends AbstractFormRequest
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
            "service_status" => "required|in:not-started,starting,downloading,failed,initiating,completed",
            "service_report" => "required|string"
        ];
    }
}