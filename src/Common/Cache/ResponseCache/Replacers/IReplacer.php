<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\Replacers;


use Symfony\Component\HttpFoundation\Response;

/**
 * Interface IReplacer
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Replacers
 */
interface IReplacer
{

    /*
     * Prepare the initial response before it gets cached.
     */
    /**
     * @param Response $response
     */
    public function prepareResponseToCache(Response $response);
    /*
     * Replace any data you want in the cached response before it gets sent.
     */
    /**
     * @param Response $response
     */
    public function replaceInCachedResponse(Response $response);

}