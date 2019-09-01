<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\CacheProfiles;


use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class CacheAllSuccessfulGetRequests
 * @package PlusClouds\Core\Common\Cache\ResponseCache\CacheProfiles
 */
class CacheAllSuccessfulGetRequests extends AbstractCacheProfile
{

    /**
     * @param Request $request
     *
     * @return bool
     */
    public function shouldCacheRequest(Request $request) {
        if( $request->ajax() ) {
            return false;
        }

        if( $this->isRunningInConsole() ) {
            return false;
        }

        return $request->isMethod( 'get' );
    }

    /**
     * @param Response $response
     *
     * @return bool
     */
    public function shouldCacheResponse(Response $response) {
        if( ! $this->hasCacheableResponseCode( $response ) ) {
            return false;
        }

        if( ! $this->hasCacheableContentType( $response ) ) {
            return false;
        }

        return true;
    }

    /**
     * @param Response $response
     *
     * @return bool
     */
    public function hasCacheableResponseCode(Response $response) {
        if( $response->isSuccessful() ) {
            return true;
        }

        if( $response->isRedirection() ) {
            return true;
        }

        return false;
    }

    /**
     * @param Response $response
     *
     * @return bool
     */
    public function hasCacheableContentType(Response $response) {
        $contentType = $response->headers->get( 'Content-Type', '' );

        if( Str::startsWith( $contentType, 'text' ) ) {
            return true;
        }

        if( Str::contains( $contentType, 'application/json' ) ) {
            return true;
        }

        return false;
    }

}