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

use Illuminate\Support\Facades\Log;
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

        $this->bootLogger();
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
        $this->registerCommands();

        $this->mergeConfigFrom( __DIR__.'/../config/core.php', 'core' );
        $this->mergeConfigFrom( __DIR__.'/../config/relation.php', 'relation' );
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
     * @todo ElasticSearchHandler eklenecek!
     *
     * @return void
     */
    public function bootLogger() {
        $monolog = Log::getMonolog();

        // @todo SlackWebHookHandler çalışmıyor!
//        $slackHandler = new \Monolog\Handler\SlackWebhookHandler(
//            'https://hooks.slack.com/services/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'
//        );
//
//        $slackHandler->setFormatter( new \Monolog\Formatter\LineFormatter() );
//
//        $monolog->pushHandler( $slackHandler );

        $monolog->pushProcessor( new \Monolog\Processor\WebProcessor() );
        $monolog->pushProcessor( new \Monolog\Processor\MemoryUsageProcessor() );
        $monolog->pushProcessor( new \Monolog\Processor\MemoryPeakUsageProcessor() );
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
     * @return void
     */
    private function registerCommands() {
        if( $this->app->runningInConsole() ) {
            $this->commands( [
                'PlusClouds\Core\Console\Commands\FetchDisposableEmailDomainsCommand',
            ] );
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