<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use Symfony\Component\Debug\Exception\FatalThrowableError;
use Illuminate\Support\Facades\Blade;

/**
 * @param $template
 * @param array $data
 *
 * @return string
 * @throws FatalThrowableError
 */
function template($template, $data = []) {
    $compiled = Blade::compileString( $template );

    $obLevel = ob_get_level();

    ob_start();

    extract( $data, EXTR_SKIP );

    try {
        eval( '?'.'>'.$compiled );
    }
    catch( Exception $e ) {
        while( ob_get_level() > $obLevel ) {
            ob_end_clean();
        }

        throw $e;
    }
    catch( Throwable $e ) {
        while( ob_get_level() > $obLevel ) {
            ob_end_clean();
        }

        throw new FatalThrowableError( $e );
    }

    return ob_get_clean();
}