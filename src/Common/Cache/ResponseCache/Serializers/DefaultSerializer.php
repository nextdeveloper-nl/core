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
use Illuminate\Http\Response as IlluminateResponse;
use Symfony\Component\HttpFoundation\BinaryFileResponse;
use PlusClouds\Core\Common\Cache\ResponseCache\Exceptions\CouldNotUnserialize;

/**
 * Class DefaultSerializer
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Serializers
 */
class DefaultSerializer implements ISerializable
{

    /**
     * @var string
     */
    public const RESPONSE_TYPE_NORMAL = 'normal';

    /**
     * @var string
     */
    public const RESPONSE_TYPE_FILE = 'file';

    /**
     * @param Response $response
     *
     * @return string
     */
    public function serialize(Response $response) {
        return serialize( $this->getResponseData( $response ) );
    }

    /**
     * @param string $serializedResponse
     *
     * @return Response
     * @throws CouldNotUnserialize
     */
    public function unserialize(string $serializedResponse) {
        $responseProperties = unserialize( $serializedResponse );

        if( ! $this->containsValidResponseProperties( $responseProperties ) ) {
            throw CouldNotUnserialize::serializedResponse( $serializedResponse );
        }

        $response = $this->buildResponse( $responseProperties );
        $response->headers = $responseProperties['headers'];

        return $response;
    }

    /**
     * @param Response $response
     *
     * @return array
     */
    protected function getResponseData(Response $response) {
        $statusCode = $response->getStatusCode();
        $headers = $response->headers;

        if( $response instanceof BinaryFileResponse ) {
            $content = $response->getFile()->getPathname();
            $type = static::RESPONSE_TYPE_FILE;

            return compact( 'statusCode', 'headers', 'content', 'type' );
        }

        $content = $response->getContent();
        $type = static::RESPONSE_TYPE_NORMAL;

        return compact( 'statusCode', 'headers', 'content', 'type' );
    }

    /**
     * @param $properties
     *
     * @return bool
     */
    protected function containsValidResponseProperties($properties) {
        if( ! is_array( $properties ) ) {
            return false;
        }

        if( ! isset( $properties['content'], $properties['statusCode'] ) ) {
            return false;
        }

        return true;
    }

    /**
     * @param array $responseProperties
     *
     * @return Response
     */
    protected function buildResponse(array $responseProperties) {
        $type = $responseProperties['type'] ?? static::RESPONSE_TYPE_NORMAL;

        if( $type === static::RESPONSE_TYPE_FILE ) {
            return new BinaryFileResponse(
                $responseProperties['content'],
                $responseProperties['statusCode']
            );
        }

        return new IlluminateResponse( $responseProperties['content'], $responseProperties['statusCode'] );
    }

}