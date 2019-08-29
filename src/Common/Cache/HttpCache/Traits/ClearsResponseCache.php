<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\Traits;


use Spatie\ResponseCache\Facades\ResponseCache;

/**
 * Trait ClearsResponseCache
 * @package PlusClouds\Core\Common\Cache\Traits
 */
trait ClearsResponseCache
{

    /**
     * @return void
     */
    public static function bootClearsResponseCache() {
        self::created( function() {
            ResponseCache::clear();
        } );

        self::updated( function() {
            ResponseCache::clear();
        } );

        self::deleted( function() {
            ResponseCache::clear();
        } );
    }
}