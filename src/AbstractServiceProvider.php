<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Arr;

/**
 * Class AbstractServiceProvider
 * @package PlusClouds\Core
 */
abstract class AbstractServiceProvider extends ServiceProvider
{

    /**
     * @var bool|string
     */
    protected $dir;


    /**
     * AbstractServiceProvider constructor.
     *
     * @param $app
     *
     * @throws \ReflectionException
     */
    public function __construct($app) {
        parent::__construct( $app );

        $reflection = new \ReflectionClass( get_called_class() );
        $file = $reflection->getFileName();
        $this->dir = realpath( dirname( $file ) );
    }


    /**
     * @return void
     */
    protected function bootModelBindings() {
        $bindings = require_once( $this->dir.'/../config/model-binding.php' );

        if( is_array( $bindings ) && count( $bindings ) > 0 ) {
            foreach( $bindings as $key => $value ) {
                if( is_callable( $value ) ) {
                    $this->app['router']->bind( $key, $value );
                } else {
                    $this->app['router']->model( $key, $value );
                }
            }
        }
    }

    /**
     * Denetleyiciler kaydediliyor.
     *
     * @param string $key
     *
     * @return void
     */
    protected function registerMiddlewares($key) {
        $kernel = $this->app['Illuminate\Contracts\Http\Kernel'];

        // Register HTTP middleware
        if( ! empty( $hr = config( sprintf( '%s.middlewares.http', $key ) ) ) ) {
            foreach( $hr as $middleware ) {
                $kernel->pushMiddleware( $middleware );
            }
        }

        // Register Route middleware
        if( ! empty( $rr = config( sprintf( '%s.middlewares.route', $key ) ) ) ) {
            foreach( $rr as $key => $middleware ) {
                $this->app['router']->aliasMiddleware( $key, $middleware );
            }
        }
    }

    /**
     * Helper dosyaları yükleniyor.
     *
     * @return void
     */
    protected function registerHelpers() {
        $fileSystem = $this->app['Illuminate\Filesystem\Filesystem'];
        $helpers = $this->dir.DIRECTORY_SEPARATOR.'Helpers'.DIRECTORY_SEPARATOR.'*.php';

        foreach( $fileSystem->glob( $helpers ) as $file ) {
            require_once( $file );
        }
    }

    /**
     * @param $path
     * @param $key
     */
    protected function customMergeConfigFrom($path, $key) {
        //Get module app config
        $config = $this->app['config']->get( $key, [] );
        //Get module config
        $module_config = require $path;
        //recursive replace (also merges). Prefer app-specific config
        $combined_config = array_replace_recursive( $module_config, $config );

        //Recursive closure which removes null from the config
        $filter_nulls = null;
        $filter_nulls = function($input) use (&$filter_nulls) {
            if( is_array( $input ) ) {
                foreach( $input as &$value ) {
                    // is_callable check just for IDE error supression, since the function itself should be callable
                    if( is_array( $value ) && is_callable( $filter_nulls ) ) {
                        $value = $filter_nulls( $value );
                    }
                }
            }

            // Keep not-null values
            return array_filter( $input, function($v) {
                return ! is_null( $v );
            } );
        };
        // Apply filter
        $filtered_config = $filter_nulls( $combined_config );
        // And set
        $this->app['config']->set( $key, $filtered_config );
    }

}