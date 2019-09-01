<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\Exceptions;


use Exception;

/**
 * Class CouldNotUnserialize
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Exceptions
 */
class CouldNotUnserialize extends Exception
{

    /**
     * @param string $serializedResponse
     *
     * @return CouldNotUnserialize
     */
    public static function serializedResponse(string $serializedResponse) : self {
        return new static( "Could not unserialize serialized response `{$serializedResponse}`" );
    }

}