<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache;


use PlusClouds\Core\Common\Cache\ResponseCache\Exceptions\CouldNotUnserialize;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Http\Response as IlluminateResponse;
use Symfony\Component\HttpFoundation\BinaryFileResponse;

/**
 * Class ResponseSerializer
 * @package PlusClouds\Core\Common\Cache\ResponseCache
 */
class ResponseSerializer
{

    /**
     * @var string
     */
    public const RESPONSE_TYPE_NORMAL = 'response_type_normal';

    /**
     * @var string
     */
    public const RESPONSE_TYPE_FILE = 'response_type_file';

    /**
     * @param Response $response
     *
     * @return string
     */
    public function serialize(Response $response) : string {
        return serialize( $this->getResponseData( $response ) );
    }

    /**
     * @param string $serializedResponse
     *
     * @return Response
     * @throws CouldNotUnserialize
     */
    public function unserialize(string $serializedResponse) : Response {
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
    protected function getResponseData(Response $response) : array {
        $statusCode = $response->getStatusCode();
        $headers = $response->headers;

        if( $response instanceof BinaryFileResponse ) {
            $content = $response->getFile()->getPathname();
            $type = self::RESPONSE_TYPE_FILE;

            return compact( 'statusCode', 'headers', 'content', 'type' );
        }

        $content = $response->getContent();
        $type = self::RESPONSE_TYPE_NORMAL;

        return compact( 'statusCode', 'headers', 'content', 'type' );
    }

    /**
     * @param $properties
     *
     * @return bool
     */
    protected function containsValidResponseProperties($properties) : bool {
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
    protected function buildResponse(array $responseProperties) : Response {
        $type = $responseProperties['type'] ?? self::RESPONSE_TYPE_NORMAL;

        if( $type === self::RESPONSE_TYPE_FILE ) {
            return new BinaryFileResponse(
                $responseProperties['content'],
                $responseProperties['statusCode']
            );
        }

        return new IlluminateResponse( $responseProperties['content'], $responseProperties['statusCode'] );
    }

}