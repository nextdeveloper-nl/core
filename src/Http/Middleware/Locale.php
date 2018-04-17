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

/**
 * Class Locale
 * @package PlusClouds\Core\Http\Middleware
 */
class Locale
{

    /**
     * @param $request
     * @param Closure $next
     *
     * @return mixed
     */
    public function handle($request, Closure $next) {
        $locales = config( 'core.locale.available' );
        $default = config( 'core.locale.default' );

        if( ! $request->has( 'locale' ) ) {
            $request->merge( [ 'locale' => $default ] );
        }

        $locale = $request->get( 'locale' );

        if( ! in_array( $locale, $locales ) ) {
            $locale = $default;
        }

        app()->setLocale( strtolower( $locale ) );

        return $next( $request );
    }

}