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

        if( count( $bindings ) ) {
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
        if( count( $hr = config( sprintf( '%s.middlewares.http', $key ) ) ) ) {
            foreach( $hr as $middleware ) {
                $kernel->pushMiddleware( $middleware );
            }
        }

        // Register Route middleware
        if( count( $rr = config( sprintf( '%s.middlewares.route', $key ) ) ) ) {
            foreach( $rr as $key => $middleware ) {
                $this->app['router']->middleware( $key, $middleware );
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

}