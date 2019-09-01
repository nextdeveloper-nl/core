<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\Middlewares;


use Closure;
use Illuminate\Http\Request;

/**
 * Class DoNotCacheResponse
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Middlewares
 */
class DoNotCacheResponse
{

    /**
     * @param Request $request
     * @param Closure $next
     *
     * @return mixed
     */
    public function handle(Request $request, Closure $next) {
        $request->attributes->add( [ 'response_cache.doNotCache' => true ] );

        return $next( $request );
    }

}