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

    /**
     * @var string
     */
    protected $projectPath;

    /**
     * AbstractServiceProvider constructor.
     *
     * @param Application $app
     */
    public function __construct(Application $app) {
        parent::__construct( $app );

        // Proje yolu ayarlanıyor.
        $projectFolder = implode( DIRECTORY_SEPARATOR, explode( '\\', __NAMESPACE__ ) );

        $this->projectPath = base_path().'vendor/'.$projectFolder;
    }


    /**
     * Helper dosyaları yükleniyor.
     *
     * @return void
     */
    protected function registerHelpers() {
        $fileSystem = $this->app['Illuminate\Filesystem\Filesystem'];
        $helpers = $this->projectPath.DIRECTORY_SEPARATOR.'Helpers'. DIRECTORY_SEPARATOR .'*.php';

        foreach( $fileSystem->glob( $helpers ) as $file ) {
            require_once( $file );
        }
    }

}