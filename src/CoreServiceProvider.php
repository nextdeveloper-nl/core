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


use Illuminate\Database\Eloquent\Builder;
use Illuminate\Broadcasting\BroadcastManager;
use Illuminate\Support\Facades\Log;
use Illuminate\Contracts\Debug\ExceptionHandler;
use PlusClouds\Core\Common\Broadcasting\Broadcasters\PushStreamBroadcaster;
use PlusClouds\Core\Common\Logger\Monolog\Handler\GraylogHandler;
use PlusClouds\Core\Common\Services\NiN\NiN;
use PlusClouds\Core\Exceptions\Handler;
use PlusClouds\Core\Common\Registry\Drivers\IDriver;
use PlusClouds\Core\Http\Traits\Response\Responsable;
use Monolog\Formatter\GelfMessageFormatter;
use Twilio\Rest\Client as TwilioClient;
use GuzzleHttp\Client as GuzzleClient;
use InvalidArgumentException;

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
        $this->bootEloquentMacros();

//        $this->bootPushStreamBroadcaster();
        $this->bootTwilio();
        $this->bootNiN();
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
        $this->customMergeConfigFrom( __DIR__.'/../config/relation.php', 'relation' );
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

        // @todo : Graylog aktif edilecek.
//        $graylogHandler = new GraylogHandler();
//        $graylogHandler->setFormatter( new GelfMessageFormatter() );
//
//        $monolog->pushHandler( $graylogHandler );

        $monolog->pushProcessor( new \Monolog\Processor\WebProcessor() );
        $monolog->pushProcessor( new \Monolog\Processor\MemoryUsageProcessor() );
        $monolog->pushProcessor( new \Monolog\Processor\MemoryPeakUsageProcessor() );
    }

    /**
     * @return void
     */
    protected function bootEloquentMacros() {
        Builder::macro( 'toSqlWithBindings', function() {
            $sql = $this->toSql();

            foreach( $this->getBindings() as $binding ) {
                $value = is_numeric( $binding ) ? $binding : "'$binding'";
                $sql = preg_replace( '/\?/', $value, $sql, 1 );
            }

            return $sql;
        } );

        Builder::macro( 'dd', function() {
            if( func_num_args() === 1 ) {
                $message = func_get_arg( 0 );
            }

            dump( ( empty( $message ) ? "" : $message.": " ).$this->toSqlWithBindings() );

            dd( $this->get() );
        } );

        Builder::macro( 'dump', function() {
            if( func_num_args() === 1 ) {
                $message = func_get_arg( 0 );
            }

            dump( ( empty( $message ) ? "" : $message.": " ).$this->toSqlWithBindings() );

            return $this;
        } );

        Builder::macro( 'log', function() {
            if( func_num_args() === 1 ) {
                $message = func_get_arg( 0 );
            }

            logger()->debug( ( empty( $message ) ? "" : $message.": " ).$this->toSqlWithBindings() );

            return $this;
        } );
    }

    /**
     * Nginx Push Stream
     *
     * @return void
     */
    public function bootPushStreamBroadcaster() {
        $this->app->make( BroadcastManager::class )->extend( 'PushStream', function($app, $config) {
            $client = new GuzzleClient( [
                'base_uri' => config( 'core.pushstream.base_url' ),
                'query'    => ! is_null( config( 'core.pushstream.access_key' ) ) ? [
                    'access_key' => config( 'core.pushstream.access_key' ),
                ] : null,
            ] );

            if( ! is_null( config( 'core.pushstream.cert' ) ) ) {
                $client->setDefaultOption( 'verify', config( 'core.pushstream.cert' ) );
            }

            return new PushStreamBroadcaster( $client );
        } );
    }

    /**
     * Twilio servisini kaydeder.
     *
     * @return void
     */
    private function bootTwilio() {
        $this->app->singleton( 'Twilio', function() {
            return new TwilioClient( env( 'TWILIO_ACCOUNT_SID' ), env( 'TWILIO_AUTH_TOKEN' ) );
        } );
    }

    /**
     * NiN servisini kaydeder.
     *
     * return @void
     */
    private function bootNiN() {
        $this->app->singleton( 'NiN', NiN::class );
    }

    /**
     * Rota'ları kaydeder.
     *
     * @return void
     */
    private function registerRoutes() {
        if( ! $this->app->routesAreCached() ) {
            $this->app['router']->prefix( 'v2' )
                ->middleware( [ 'api', 'team-finder' ] )
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