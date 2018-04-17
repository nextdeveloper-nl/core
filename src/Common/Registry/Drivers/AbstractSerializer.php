<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Registry\Drivers;

/**
 * Class AbstractSerializer
 * @package PlusClouds\Core\Common\Registry\Drivers
 */
abstract class AbstractSerializer
{

    /**
     * @param mixed $value
     * @param int $options
     * @param int $depth
     *
     * @return string
     */
    protected function serialize($value, $options = 0, $depth = 512) {
        return json_encode( $value, $options, $depth );
    }

    /**
     * @param string $json
     * @param bool $assoc
     * @param int $depth
     * @param int $options
     *
     * @return mixed|null
     */
    protected function deserialize($json, $assoc = false, $depth = 512, $options = 0) {
        $data = json_decode( $json, $assoc, $depth, $options );

        if( JSON_ERROR_NONE !== json_last_error() ) {
            return $json;
        }

        return $data;
    }

}