<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use PlusClouds\Core\Database\Models\Country;

/**
 * Ülkeleri döndürür.
 *
 * @return mixed
 */
function getCountries() {
    return Country::orderByRaw( 'CONVERT( `phone_code`, unsigned )' )->get();
}

/**
 * Ülke bilgisini döndürür.
 *
 * @param int $id
 *
 * @return mixed
 */
function getCountryById($id) {
    return Country::find( $id );
}

/**
 * Ülke koduna göre, ülke bilgisini döndürür.
 *
 * @param string $code
 *
 * @return mixed
 */
function getCountryByCode($code) {
    return Country::code( $code )->firstOrFail();
}

/**
 * Yerelleştirme koduna göre, ülke bilgisini döndürür.
 *
 * @param string $locale
 *
 * @return Country
 */
function getCountriesByLocale($locale) {
    return Country::locale( $locale )->get();
}

/**
 * Telefon koduna göre, ülke bilgisini döndürür.
 *
 * @param string $code
 *
 * @return Country
 */
function getCountryByPhoneCode($code) {
    return Country::phoneCode( $code )->firstOrFail();
}

/**
 * @param array $list
 *
 * @return array
 */
function acceptableCountries(array $list) {
    return array_filter( $list, function($id) {
        return ! empty( $id ) && getCountryById( $id );
    } );
}