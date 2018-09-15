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
     */
    public function handle(Request $request, Closure $next) {
        // @todo : Kullanının ip adresine göre ülkeyi bulacağız.
        // geçici olarak Türkiyeyi seçiyoruz.

        $request->attributes->set( 'country', Country::findOrFail( 1 ) );

        return $next( $request );
    }

}