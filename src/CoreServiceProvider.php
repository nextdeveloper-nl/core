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

use InvalidArgumentException;
use Illuminate\Contracts\Debug\ExceptionHandler;
use PlusClouds\Core\Exceptions\Handler;
use PlusClouds\Core\Common\Registry\Drivers\IDriver;
use PlusClouds\Core\Http\Traits\Response\Responsable;

/**
 * Class CoreServiceProvider
 * @package PlusClouds\Core
 */
class CoreServiceProvider extends AbstractServiceProvider
{

    /**
     * @var bool
     */
    protected $defer = false;

    /**
     * @return void
     */
    public function boot() {
        $this->publishes( [
            __DIR__.'/../config/core.php' => config_path( 'core.php' ),
        ], 'config' );

        $this->loadViewsFrom( $this->dir.'/../resources/views', 'Core' );

        $this->bootErrorHandler();
        $this->bootModelBindings();
    }

    /**
     * @return void
     */
    public function register() {
        // Register Response Api Macro
        $this->app['Illuminate\Contracts\Routing\ResponseFactory']->macro( 'api', function() {
            return new class
            {

                use Responsable;
            };
        } );

        $this->registerRegistry();
        $this->registerHelpers();
        $this->registerMiddlewares( 'core' );
        $this->registerRoutes();

        $this->mergeConfigFrom( __DIR__.'/../config/core.php', 'core' );
    }

    /**
     * @return array
     */
    public function provides() {
        return [ 'core' ];
    }

    /**
     * Hata işleyiciyi değiştiriyoruz.
     *
     * @return void
     */
    public function bootErrorHandler() {
        $this->app->singleton(
            ExceptionHandler::class,
            Handler::class
        );
    }

    /**
     * Rota'ları kaydeder.
     *
     * @return void
     */
    private function registerRoutes() {
        if( ! $this->app->routesAreCached() ) {
            $this->app['router']->prefix( 'v2' )
                ->middleware( 'api' )
                ->namespace( 'PlusClouds\Core\Http\Controllers' )
                ->group( __DIR__.DIRECTORY_SEPARATOR.'Http'.DIRECTORY_SEPARATOR.'api.routes.php' );
        }
    }

    /**
     * Kayıt defteri ayarları yapılıyor.
     *
     * @return void
     */
    private function registerRegistry() {
        $this->app->bind( IDriver::class, function($app) {
            $driver = ucfirst( config( 'core.registry.driver', 'database' ) );
            $class = sprintf( 'PlusClouds\Core\Common\Registry\Drivers\%s', $driver );

            switch( $driver ) {
                case 'Database' :
                    $driver = new $class( $app['db'], $app['config'], $app['cache.store'] );
                    break;
                case 'File' :
                    $driver = new $class( $app['config'] );
                    break;
                default :
                    throw new InvalidArgumentException( 'Unknown Registry Driver!' );
            }

            return $driver;
        } );

        $this->app->singleton( 'registry', IDriver::class );
    }

}