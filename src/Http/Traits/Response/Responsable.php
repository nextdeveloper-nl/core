<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Traits\Response;

use Symfony\Component\HttpFoundation\Response;
use PlusClouds\Core\Common\Contracts\IResource;

/**
 * Trait Responsable
 * @package PlusClouds\Core\Http\Traits\Response
 */
trait Responsable
{

    /**
     * @var null|string|int
     */
    protected $ref;

    /**
     * @var int
     */
    protected $statusCode = 200;

    /**
     * @return null|string|int
     */
    public function getRef() {
        return $this->ref;
    }

    /**
     * @param null|string|int $value
     *
     * @return $this
     */
    public function setRef($value) {
        $this->ref = $value;

        return $this;
    }

    /**
     * @param int $code
     *
     * @return $this
     */
    protected function setStatusCode($code) {
        $this->statusCode = $code;

        return $this;
    }

    /**
     * @param IResource $resource
     * @param array $headers
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function withItem(IResource $resource, array $headers = []) {
        return $this->withArray( $resource, $headers );
    }

    /**
     * @param IResource $resource
     * @param array $headers
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function withCollection(IResource $resource, array $headers = []) {
        return $this->withArray( $resource, $headers );
    }

    /**
     * @param string $message
     * @param string|int $code
     * @param array $errors
     * @param array $headers
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function withError($message, $code, array $errors = [], array $headers = []) {
        $data = [
            'error' => [
                'status'  => $this->statusCode,
                'ref'     => $this->ref ?? 0,
                'code'    => $code,
                'message' => $message,
            ],
        ];

        if( ! empty( $errors ) ) {
            array_set( $data, 'error.errors', $errors );
        }

        return $this->withArray( $data, $headers );
    }

    /**
     * @param array|IResource $data
     * @param array $headers
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function withArray($data, array $headers = []) {
        if( ! empty( $this->getRef() ) ) {
            $headers = array_merge( [ 'X-Request-Ref' => $this->getRef() ], $headers );
        }

        if( $data instanceof IResource ) {
            return $data->response()
                ->setStatusCode( $this->statusCode )
                ->withHeaders( $headers );
        }

        return response()->json( $data, $this->statusCode, $headers );
    }

    /**
     * @return \Illuminate\Contracts\Routing\ResponseFactory|Response
     */
    public function noContent() {
        return response( null, Response::HTTP_NO_CONTENT );
    }

    /**
     * Generates a response with a 400 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorBadRequest($message = 'Bad Request', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_BAD_REQUEST )
            ->withError( $message, 'ERROR-BAD-REQUEST', $errors, $headers );
    }

    /**
     * Generates a response with a 401 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorUnauthorized($message = 'Unauthorized', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_UNAUTHORIZED )
            ->withError( $message, 'ERROR-UNAUTHORIZED', $errors, $headers );
    }

    /**
     * Generates a response with a 403 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorForbidden($message = 'Forbidden', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_FORBIDDEN )
            ->withError( $message, 'ERROR-FORBIDDEN', $errors, $headers );
    }

    /**
     * Generates a response with a 404 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorNotFound($message = 'Requested object not found', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_NOT_FOUND )
            ->withError( $message, 'ERROR-NOT-FOUND', $errors, $headers );
    }

    /**
     * Generates a response with a 405 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorMethodNotAllowed($message = 'Method Not Allowed', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_METHOD_NOT_ALLOWED )
            ->withError( $message, 'ERROR-METHOD-NOT-ALLOWED', $errors, $headers );
    }

    /**
     * Generates a response with a 406 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorNotAcceptable($message = 'Not Acceptable', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_NOT_ACCEPTABLE )
            ->withError( $message, 'ERROR-NOT-ACCEPTABLE', $errors, $headers );
    }

    /**
     * Generates a response with a 409 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorConflict($message = 'Conflict', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_CONFLICT )
            ->withError( $message, 'ERROR-CONFLICT', $errors, $headers );
    }

    /**
     * Generates a response with a 410 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorGone($message = 'Gone', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_GONE )
            ->withError( $message, 'ERROR-GONE', $errors, $headers );
    }

    /**
     * Generates a response with a 415 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorUnsupportedMediaType($message = 'Unsupported Media Type', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_UNSUPPORTED_MEDIA_TYPE )
            ->withError( $message, 'ERROR-UNSUPPORTED-MEDIA-TYPE', $errors, $headers );
    }

    /**
     * Generates a response with a 422 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorUnprocessable($message = 'Unprocessable Entitiy', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_UNPROCESSABLE_ENTITY )
            ->withError( $message, 'ERROR-UNPROCESSABLE-ENTITIY', $errors, $headers );
    }

    /**
     * Generates a response with a 429 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorToManyRequests($message = 'To Many Requests', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_TOO_MANY_REQUESTS )
            ->withError( $message, 'ERROR-TOO-MANY-REQUESTS', $errors, $headers );
    }

    /**
     * Generates a response with a 500 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorInternal($message = 'Internal Server Error', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_INTERNAL_SERVER_ERROR )
            ->withError( $message, 'ERROR-INTERNAL-ERROR', $errors, $headers );
    }

    /**
     * Generates a response with a 501 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorNotImplemented($message = 'Not Implemented', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_NOT_IMPLEMENTED )
            ->withError( $message, 'ERROR-NOT-IMPLEMENTED', $errors, $headers );
    }

    /**
     * Generates a response with a 502 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorBadGateway($message = 'Bad Gateway', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_BAD_GATEWAY )
            ->withError( $message, 'ERROR-BAD-GATEWAY', $errors, $headers );
    }

    /**
     * Generates a response with a 503 HTTP header and a given message.
     *
     * @param string $message
     * @param array $errors
     * @param array $headers
     *
     * @return mixed
     */
    public function errorServiceUnavailable($message = 'Service Unavailable', array $errors = [], array $headers = []) {
        return $this->setStatusCode( Response::HTTP_SERVICE_UNAVAILABLE )
            ->withError( $message, 'ERROR-SERVICE-UNAVAILABLE', $errors, $headers );
    }

}