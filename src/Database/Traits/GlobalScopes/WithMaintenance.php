<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits\GlobalScopes;


use PlusClouds\Core\Database\GlobalScopes\MaintenanceScope;

/**
 * Trait WithMaintenance
 * @package PlusClouds\Core\Database\Traits\GlobalScopes
 */
trait WithMaintenance
{

    /**
     * @return void
     */
    public static function bootWithMaintenance() {
        static::addGlobalScope( new MaintenanceScope() );
    }

    /**
     * @return mixed
     */
    public static function withMaintenance() {
        return static::withoutGlobalScope( MaintenanceScope::class);
    }

}