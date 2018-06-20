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


use PlusClouds\Core\Database\GlobalScopes\PublicScope;

/**
 * Trait WithPrivate
 * @package PlusClouds\Core\Database\Traits\GlobalScopes
 */
trait WithPrivate
{

    /**
     * @return void
     */
    public static function bootWithPrivate() {
        static::addGlobalScope( new PublicScope() );
    }

    /**
     * @return mixed
     */
    public static function withPrivate() {
        return static::withoutGlobalScope( PublicScope::class);
    }

}