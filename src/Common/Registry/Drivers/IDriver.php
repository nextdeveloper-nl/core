<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Registry\Drivers;

/**
 * Interface IDriver
 * @package PlusClouds\Core\Common\Registry
 */
interface IDriver
{

    /**
     * Kaydedilmiş verileri yükler.
     *
     * @return void
     */
    public function load();

    /**
     * Yeni bir veri kaydeder.
     *
     * @param string|null $key
     * @return void
     */
    public function write($key = null);

    /**
     * Kaydedilmiş tüm verileri getirir.
     *
     * @return array
     */
    public function all();

    /**
     * Belli bir anahtara göre veriyi getirir.
     *
     * @param string $key
     * @param mixed $default
     *
     * @return mixed
     */
    public function get($key, $default = null);

    /**
     * Bir anahtarın varlığını kontrol eder.
     *
     * @param string $key
     *
     * @return mixed
     */
    public function has($key);

    /**
     * Bir anahtarı kaydeder.
     *
     * @param string $key
     * @param mixed $value
     *
     * @return array
     */
    public function put($key, $value);

    /**
     * Kaydedilmiş verileri yeniden yükler.
     *
     * @return void
     */
    public function refresh();

    /**
     * Verilen anahtara göre veriyi siler.
     *
     * @param string $key
     *
     * @return void
     */
    public function forget($key);

    /**
     * Kaydedilmiş bütün verileri siler.
     *
     * @return void
     */
    public function flush();

}