<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache;

/**
 * Trait ClearsResponseCache
 * @package PlusClouds\Core\Common\Cache\ResponseCache
 */
trait ClearsResponseCache
{

    /**
     * @return void
     */
    public static function bootClearsResponseCache() {
        self::created( function() {
            app( 'responsecache' )->clear( self::$response_cache_tags ?? [] );
        } );

        self::updated( function() {
            app( 'responsecache' )->clear( self::$response_cache_tags ?? [] );
        } );

        self::deleted( function() {
            app( 'responsecache' )->clear( self::$response_cache_tags ?? [] );
        } );
    }
}