<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Controllers;

use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;

use PlusClouds\Core\Common\Registry\Drivers\File;
use PlusClouds\Core\Database\Models\Meta;
use PlusClouds\Core\Database\Models\ServiceRole;
use PlusClouds\Core\Http\Requests\ServiceRole\ServiceRoleAnsibleCallbackRequest;
use PlusClouds\Core\Http\Requests\ServiceRole\ServiceRoleServiceCallbackRequest;
use PlusClouds\Core\Http\Requests\Vote\VoteStoreRequest;
use PlusClouds\Core\Http\Requests\Vote\VoteUpdateRequest;

/**
 * Class StateController
 * @package PlusClouds\Core\Http\Controllers
 */
class ServiceRoleController extends AbstractController
{
    public function serviceUpdate(ServiceRole $serviceRole, ServiceRoleServiceCallbackRequest $request)
    {
        $validated = $request->validated();

        $serviceRole->update($validated);

        return $this->noContent();
    }

    public function ansibleUpdate(ServiceRole $serviceRole, ServiceRoleAnsibleCallbackRequest $request)
    {
        $val = $request->validated();

        $serviceRole->update($val);

        $serviceRole->fresh();

        if ($serviceRole->service_status == "completed" && $serviceRole->ansible_status == "completed") {
            $serviceRole->update(
                [
                    "has_update" => false
                ]
            );
        }

        return $this->noContent();
    }
}
