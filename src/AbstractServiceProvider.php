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

use Illuminate\Contracts\Foundation\Application;
use Illuminate\Support\ServiceProvider;

/**
 * Class AbstractServiceProvider
 * @package PlusClouds\Core
 */
abstract class AbstractServiceProvider extends ServiceProvider
{

    protected function bootModelBindings() {
        $bindings = require_once( __DIR__.'/../config/model-binding.php' );

        foreach( $bindings as $key => $value ) {
            if( is_callable( $value ) ) {
                $this->app['router']->bind( $key, $value );
            } else {
                $this->app['router']->model( $key, $value );
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
        $helpers = __DIR__.DIRECTORY_SEPARATOR.'Helpers'.DIRECTORY_SEPARATOR.'*.php';

        foreach( $fileSystem->glob( $helpers ) as $file ) {
            require_once( $file );
        }
    }

}