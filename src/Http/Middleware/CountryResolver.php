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
use PlusClouds\Core\Database\Models\Country;
use PlusClouds\Core\Database\Models\Ip2Location;

/**
 * Class CountryResolver
 * @package PlusClouds\Account\Http\Middleware
 */
class CountryResolver
{

    /**
     * @param Request $request
     * @param Closure $next
     *
     * @return mixed
     * @throws \Exception
     */
    public function handle(Request $request, Closure $next) {
        $countryCode = config( 'core.country_resolver.default' );

        if( app()->environment() != 'local' ) {
            // todo : Ip2Location tablosuna önbellekleme yapılmalı. 3.5M kayıt bulunmakta.
            if( $resolver = Ip2Location::select( 'country_code' )->resolve( $request->ip() )->first() ) {
                if( $resolver->country_code != '-' ) {
                    $countryCode = $resolver->country_code;
                }
            }
        }

        // Ziyaretçinin geldiği ülkeyi buluyoruz.
        $request->attributes->set( 'country', cache()->remember( 'country_resolver_'.$countryCode, 60, function() use ($countryCode) {
            return Country::code( $countryCode )->first();
        } ) );

        // Dili ülkeye göre ayarlıyoruz.
        app()->setLocale( strtolower( $request->attributes->get( 'country' )->locale ) );

        return $next( $request );
    }

}