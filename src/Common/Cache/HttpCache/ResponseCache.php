<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\HttpCache;


use Symfony\Component\HttpFoundation\Response;
use Spatie\ResponseCache\ResponseCache as HttpResponseCache;

/**
 * Class ResponseCache
 * @package PlusClouds\Core\Common\Cache\HttpCache
 */
class ResponseCache extends HttpResponseCache
{

    /**
     * @param Response $response
     *
     * @return Response
     */
    protected function addCachedHeader(Response $response) : Response {
        $clonedResponse = clone $response;
        $clonedResponse->headers->set(
            config( 'responsecache.cache_time_header_name' ),
            now()->toRfc2822String()
        );

        return $clonedResponse;
    }

}