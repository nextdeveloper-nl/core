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
        return $this->morphMany(ServiceRole::class, 'service_roles', 'object_type');
    }

    public function setServiceRole($name)
    {
        $this->serviceRoles()->create([
            'name'  =>  $name
        ]);
    }

    public function removeServiceRole($name)
    {
    }
}
