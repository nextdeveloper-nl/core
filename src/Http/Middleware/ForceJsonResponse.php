<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

/**
 * Class ForceJsonResponse.
 *
 * @package PlusClouds\Core\Http\Middleware
 */
class ForceJsonResponse {
    /**
     * Handle an incoming request.
     *
     * @param \Illuminate\Http\Request $request
     * @param \Closure                 $next
     *
     * @return mixed
     */
    public function handle(Request $request, Closure $next) {
        $request->headers->set('Accept', 'application/json');

        return $next($request);
    }
}
