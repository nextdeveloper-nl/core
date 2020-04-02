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
        // TODO : Bu kısım DB'de ki laguages tablosuna göre yapılacak
        $locales = config( 'core.locales.availables' );
        $default = config( 'core.locales.default' );

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