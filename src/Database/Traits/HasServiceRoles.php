<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;

use PlusClouds\Core\Database\Models\ServiceRole;

/**
 * Trait HasStates
 * @package PlusClouds\Core\Database\Traits
 */
trait HasServiceRoles
{
    /**
     * @return mixed
     */
    public function serviceRoles()
    {
        return $this->morphMany(ServiceRole::class, 'service_roles', 'object_type', "id");
    }

    public function setServiceRole($name, $url = null)
    {
        $reflect = new \ReflectionClass($this);
        $appEnv = env("APP_ENV");

        if ($this->serviceRoles()->where("name", $name)->count() != 0) {
            throw new \Exception("Service Role already exists on the " . $reflect->getShortName() . " Model.");
        }

        $serviceRole = $this->serviceRoles()->create([
            'name' => $name,

            "object_id" => $this->id,
            "url"       => $url ?: config("core.serviceDownloadBaseUrl") . config("core.serviceDownloadPath") . $name
        ]);

        return $serviceRole->fresh();
    }

    public function removeServiceRole($name)
    {
        $this->serviceRoles()->where("name", $name)->delete();
    }
}
