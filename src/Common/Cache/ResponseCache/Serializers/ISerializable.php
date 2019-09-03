<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\Serializers;


use Symfony\Component\HttpFoundation\Response;

/**
 * Interface ISerializable
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Serializers
 */
interface ISerializable
{

    /**
     * @param Response $response
     *
     * @return string
     */
    public function serialize(Response $response);

    /**
     * @param string $serializedResponse
     *
     * @return Response
     */
    public function unserialize(string $serializedResponse);

}