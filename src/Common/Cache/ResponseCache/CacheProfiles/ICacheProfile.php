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


use DateTime;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Interface ICacheProfile
 * @package PlusClouds\Core\Common\Cache\ResponseCache\CacheProfiles
 */
interface ICacheProfile
{

    /**
     * @param Request $request
     *
     * @return bool
     */
    public function enabled(Request $request);

    /**
     * @param Request $request
     *
     * @return bool
     */
    public function shouldCacheRequest(Request $request);

    /**
     * @param Response $response
     *
     * @return bool
     */
    public function shouldCacheResponse(Response $response);

    /**
     * @param Request $request
     *
     * @return DateTime
     */
    public function cacheRequestUntil(Request $request);

    /**
     * Return a string to differentiate this request from others.
     *
     * For example: if you want a different cache per user you could return the id of
     * the logged in user.
     *
     * @param Request $request
     *
     * @return string
     */
    public function useCacheNameSuffix(Request $request);

}