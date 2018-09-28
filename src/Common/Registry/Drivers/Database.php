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

use Illuminate\Contracts\Config\Repository as Config;
use Illuminate\Contracts\Cache\Repository as Cache;
use Illuminate\Database\DatabaseManager;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Arr;

/**
 * Class Database
 * @package PlusClouds\Core\Common\Registry\Drivers
 */
class Database extends AbstractSerializer implements IDriver
{

    /**
     * @var DatabaseManager
     */
    protected $dbManager;

    /**
     * @var Config
     */
    protected $config;

    /**
     * @var Cache
     */
    protected $cache;

    /**
     * @var string
     */
    protected $table;

    /**
     * @var array
     */
    protected $settings = [];

    /**
     * @return string
     */
    private function getTable() {
        return $this->config->get( 'core.registry.table', 'registries' );
    }

    /**
     * @return string
     */
    private function getCacheKey() {
        return $this->config->get( 'core.registry.cache.key', 'plusclouds_registries' );
    }

    /**
     * Database constructor.
     *
     * @param DatabaseManager $dbManager
     * @param Config $config
     * @param Cache $cache
     */
    public function __construct(DatabaseManager $dbManager, Config $config, Cache $cache) {
        $this->dbManager = $dbManager;
        $this->config = $config;
        $this->cache = $cache;
        $this->table = $this->getTable();
        $this->load();
    }

    /**
     * @return void
     */
    public function __destruct() {
        unset( $this->settings );
    }

    /**
     * @return void
     */
    public function load() {
        if( Schema::hasTable( ( $table = $this->table ) ) ) {
            $this->settings = $this->cache->rememberForever( $this->getCacheKey(), function() {
                if( $settings = $this->dbManager->table( $this->table )->pluck( 'value', 'key' ) ) {
                    $settings = $settings->map(function($data){
                        return ! is_array( $data ) ? $this->deserialize( $data, true ) : $data;
                    });
                }

                return $settings->toArray();
            } );
        }
    }

    /**
     * @param string|null $key
     *
     * @return void
     */
    public function write($key = null) {
        if( str_contains( $key, '.' ) ) {
            $key = head( explode( '.', $key ) );
        }

        if( ! $this->exists( $key ) ) {
            $this->dbManager->table( $this->table )->insert( [
                'key'   => $key,
                'value' => $this->serialize( $this->settings[ $key ] ),
            ] );
        } else {
            $this->dbManager->table( $this->table )->where( 'key', $key )->update( [
                'value' => $this->serialize( $this->settings[ $key ] ),
            ] );
        }

        $this->cache->forever( $this->getCacheKey(), $this->settings );
    }

    /**
     * @return array
     */
    public function all() {
        return $this->settings;
    }

    /**
     * @param string $key
     * @param null $default
     *
     * @return mixed
     */
    public function get($key, $default = null) {
        return Arr::get( $this->settings, $key, $default );
    }

    /**
     * @param string $key
     *
     * @return bool
     */
    public function has($key) {
        return Arr::has( $this->settings, $key );
    }

    /**
     * @param string $key
     * @param mixed $value
     *
     * @return array
     */
    public function put($key, $value) {
        $result = Arr::set( $this->settings, $key, $value );

        $this->write( $key );

        return $result;
    }

    /**
     * @return void
     */
    public function refresh() {
        $this->cache->forget( $this->getCacheKey() );
        $this->load();
    }

    /**
     * @param string $key
     */
    public function forget($key) {
        Arr::forget( $this->settings, $key );

        if( str_contains( $key, '.' ) ) {
            $this->write( $key );
        } else {
            $this->dbManager->table( $this->table )->where( 'key', $key )->delete();
            $this->cache->forever( $this->getCacheKey(), $this->settings );
        }
    }

    /**
     * @return void
     */
    public function flush() {
        $this->settings = [];
        $this->dbManager->table( $this->table )->truncate();
        $this->cache->forget( $this->getCacheKey() );
    }

    /**
     * @param string $key
     *
     * @return bool
     */
    private function exists($key) {
        return $this->dbManager->table( $this->table )->where( 'key', $key )->exists();
    }

}