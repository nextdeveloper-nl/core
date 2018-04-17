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
use Illuminate\Foundation\AliasLoader;
use PlusClouds\Core\Common\Registry\Drivers\IDriver;
use PlusClouds\Core\Common\Registry\Facades\Registry;

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
        ], 'core' );
    }

    /**
     * @return void
     */
    public function register() {
        $this->registerRegistry();
        $this->registerHelpers();

        // Eloquent Meta
//        $this->app->register( 'Phoenix\EloquentMeta\ServiceProvider' );

        // Hashids
//        $this->app->register( 'Vinkla\Hashids\HashidsServiceProvider' );

//        AliasLoader::getInstance()->alias( 'Hashids', 'Vinkla\Hashids\Facades\Hashids' );

        // Aloha Twilio
//        $this->app->register('Aloha\Twilio\Support\Laravel\ServiceProvider');

//        AliasLoader::getInstance()->alias( 'Twilio', 'Aloha\Twilio\Support\Laravel\Facade' );

        $this->mergeConfigFrom( __DIR__.'/../config/core.php', 'core' );
    }

    /**
     * @return array
     */
    public function provides() {
        return [ 'core' ];
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

//        AliasLoader::getInstance()->alias( 'Registry', Registry::class );
    }

}