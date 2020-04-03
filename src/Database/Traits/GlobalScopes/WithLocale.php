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

use PlusClouds\Core\Database\GlobalScopes\LocaleScope;


/**
 * Trait WithLocale
 * @package PlusClouds\Core\Database\Traits\GlobalScopes
 */
trait WithLocale
{

    /**
     * @return void
     */
    public static function bootWithLocale() {
        static::addGlobalScope( new LocaleScope() );
    }

}