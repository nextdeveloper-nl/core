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

use Exception;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Storage;
use Illuminate\Contracts\Config\Repository as Config;

class File extends AbstractSerializer implements IDriver
{

    /**
     * @var Config
     */
    protected $config;

    /**
     * @var string
     */
    protected $file;

    /**
     * @var string
     */
    protected $baseKey;

    /**
     * @var array
     */
    protected $settings = [];


    /**
     * File constructor.
     *
     * @param Config $config
     *
     * @throws Exception
     */
    public function __construct(Config $config) {
        $this->config = $config;
        $this->file = $config->get( 'core.registry.file.name', 'registries.json' );
        $this->baseKey = $config->get( 'core.registry.file.baseKey', 'settings' );
        $this->load();
    }

    /**
     * @throws Exception
     */
    public function load() {
        if( ! Storage::has( $this->file ) ) {
            throw new Exception( $this->file.' was not found!' );
        }

        if( ! ( $this->settings = $this->deserialize( Storage::get( $this->file ), true ) ) ) {
            $this->settings = [];
        }
    }

    /**
     * @param string|null $key
     *
     * @return void
     */
    public function write($key = null) {
        Storage::put( $this->file, $this->serialize( $this->settings ) );
    }

    /**
     * @return array
     */
    public function all() {
        return Arr::get( $this->settings, $this->baseKey );
    }

    /**
     * @param string $key
     * @param null $default
     *
     * @return mixed
     */
    public function get($key, $default = null) {
        return Arr::get( $this->settings, $this->baseKey.'.'.$key, $default );
    }

    /**
     * @param string $key
     *
     * @return bool
     */
    public function has($key) {
        return Arr::has( $this->settings, $this->baseKey.'.'.$key );
    }

    /**
     * @param string $key
     * @param mixed $value
     *
     * @return array
     */
    public function put($key, $value) {
        if( empty( $this->settings ) ) {
            Arr::set( $this->settings, $this->baseKey, [] );
        }

        $result = Arr::set( $this->settings, $this->baseKey.'.'.$key, $value );

        $this->write();

        return $result;
    }


    /**
     * @throws Exception
     */
    public function refresh() {
        throw new Exception( 'Not implemented!' );
    }

    /**
     * @param string $key
     */
    public function forget($key) {
        Arr::forget( $this->settings, $this->baseKey.'.'.$key );

        $this->write();
    }

    /**
     * @return void
     */
    public function flush() {
        $this->settings = [];
        $this->write();
    }

}