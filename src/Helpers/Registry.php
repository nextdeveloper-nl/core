<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

/**
 * Kaydedilmiş verileri yükler.
 *
 * @return array
 */
function registries() {
    return app( 'registry' )->all();
}

/**
 * Belli bir anahtara göre veriyi getirir.
 *
 * @param string $key
 * @param mixed $default
 *
 * @return mixed
 */
function registry($key, $default = null) {
    return app( 'registry' )->get( $key, $default );
}

/**
 * Bir anahtarın varlığını kontrol eder.
 *
 * @param string $key
 *
 * @return bool
 */
function registry_has($key) {
    return app( 'registry' )->has( $key );
}

/**
 * Bir anahtarı kaydeder.
 *
 * @param string $key
 * @param mixed $value
 *
 * @return mixed
 */
function registry_put($key, $value) {
    return app( 'registry' )->put( $key, $value );
}

/**
 * Kaydedilmiş verileri yeniden yükler.
 *
 * @return void
 */
function registry_refresh() {
    app( 'registry' )->refresh();
}

/**
 * Verilen anahtara göre veriyi siler.
 *
 * @param string $key
 *
 * @return void
 */
function registry_forget($key) {
    app( 'registry' )->forget( $key );
}

/**
 * Kaydedilmiş bütün verileri siler.
 *
 * @return void
 */
function registry_flush() {
    app( 'registry' )->flush();
}