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


use PlusClouds\Cerebro\Common\Exception\AbstractException;

/**
 * Class InvalidState
 * @package PlusClouds\Core\Exceptions
 */
class InvalidState extends AbstractException
{

    /**
     * @param $name
     *
     * @return InvalidState
     */
    public static function create($name) {
        return new self( "The state `{$name}` is an invalid status." );
    }

    /**
     * @param $request
     *
     * @return mixed
     */
    public function render($request) {
        return response()->api()->errorBadRequest( $this->getMessage() );
    }

}