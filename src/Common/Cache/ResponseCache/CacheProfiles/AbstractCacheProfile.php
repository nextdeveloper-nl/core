<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\CacheProfiles;


use DateTime;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

/**
 * Class AbstractCacheProfile
 * @package PlusClouds\Core\Common\Cache\ResponseCache\CacheProfiles
 */
abstract class AbstractCacheProfile implements ICacheProfile
{

    /**
     * @param Request $request
     *
     * @return bool
     */
    public function enabled(Request $request) {
        return config( 'core.response_cache.enabled' );
    }

    /**
     * @param Request $request
     *
     * @return DateTime
     */
    public function cacheRequestUntil(Request $request) {
        return Carbon::now()->addSeconds(
            config( 'core.response_cache.cache_lifetime_in_seconds' )
        );
    }

    /**
     * @param Request $request
     *
     * @return string
     */
    public function useCacheNameSuffix(Request $request) {
        if( Auth::check() ) {
            return Auth::id();
        }

        return '';
    }

    /**
     * @return bool
     */
    public function isRunningInConsole() : bool {
        if( app()->environment( 'testing' ) ) {
            return false;
        }

        return app()->runningInConsole();
    }

}