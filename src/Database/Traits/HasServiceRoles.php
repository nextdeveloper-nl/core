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
        return $this->morphMany(ServiceRole::class, 'service_roles', 'object_type', "object_id");
    }

    public function setServiceRole($name, $url = null)
    {
        $reflect = new \ReflectionClass($this);
        $appEnv = env("APP_ENV");

        if ($this->serviceRoles()->where("name", $name)->count() != 0) {
            $this->serviceRoles()->where("name", $name)->first()->update(["has_update" => true]);
        }

        $serviceRole = $this->serviceRoles()->updateOrCreate(
            ['name' => $name],
            ["url" => $url ?: config("core.serviceDownloadBaseUrl") . config("core.serviceDownloadPath") . $name . ".tar.gz"]
        );

        return $serviceRole->fresh();
    }

    public function removeServiceRole($name)
    {
        $this->serviceRoles()->where("name", $name)->delete();
    }
}
