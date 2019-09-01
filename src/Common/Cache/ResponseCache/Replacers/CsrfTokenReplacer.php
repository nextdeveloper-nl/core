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
 * Class CsrfTokenReplacer
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Replacers
 */
class CsrfTokenReplacer implements IReplacer
{

    /**
     * @var string
     */
    protected $replacementString = '<laravel-responsecache-csrf-token-here>';

    /**
     * @param Response $response
     */
    public function prepareResponseToCache(Response $response) : void {
        if( ! $response->getContent() ) {
            return;
        }

        $response->setContent( str_replace(
            csrf_token(),
            $this->replacementString,
            $response->getContent()
        ) );
    }

    /**
     * @param Response $response
     */
    public function replaceInCachedResponse(Response $response) : void {
        if( ! $response->getContent() ) {
            return;
        }

        $response->setContent( str_replace(
            $this->replacementString,
            csrf_token(),
            $response->getContent()
        ) );
    }

}