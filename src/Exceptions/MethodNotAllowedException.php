<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Exceptions;


/**
 * Class MethodNotAllowedException
 * @package PlusClouds\Core\Exceptions
 */
class MethodNotAllowedException extends AbstractCoreException
{

    /**
     * @param  \Illuminate\Http\Request
     *
     * @return mixed
     */
    public function render($request) {
        return response()->api()->errorMethodNotAllowed( 'Methot not allowed.' );
    }

}