<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\Middlewares;


use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use PlusClouds\Core\Common\Cache\ResponseCache\Events\CacheMissed;
use PlusClouds\Core\Common\Cache\ResponseCache\Events\ResponseCacheHit;
use PlusClouds\Core\Common\Cache\ResponseCache\Replacers\IReplacer;
use PlusClouds\Core\Common\Cache\ResponseCache\ResponseCache;
use Symfony\Component\HttpFoundation\Response;


/**
 * Class CacheResponse
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Middlewares
 */
class CacheResponse
{

    /** @var ResponseCache */
    protected $responseCache;

    /**
     * CacheResponse constructor.
     *
     * @param ResponseCache $responseCache
     */
    public function __construct(ResponseCache $responseCache) {
        $this->responseCache = $responseCache;
    }

    /**
     * @param Request $request
     * @param Closure $next
     * @param mixed $args
     *
     * @return Response
     */
    public function handle(Request $request, Closure $next, ...$args) {
        $lifetimeInSeconds = $this->getLifetime( $args );
        $tags = $this->getTags( $args );

        if( $this->responseCache->enabled( $request ) ) {
            if( $this->responseCache->hasBeenCached( $request, $tags ) ) {
                event( new ResponseCacheHit( $request ) );

                $response = $this->responseCache->getCachedResponseFor( $request, $tags );

                $this->getReplacers()->each( function(IReplacer $replacer) use ($response) {
                    $replacer->replaceInCachedResponse( $response );
                } );

                return $response;
            }
        }

        $response = $next( $request );

        if( $this->responseCache->enabled( $request ) ) {
            if( $this->responseCache->shouldCache( $request, $response ) ) {
                $this->makeReplacementsAndCacheResponse( $request, $response, $lifetimeInSeconds, $tags );
            }
        }
        event( new CacheMissed( $request ) );

        return $response;
    }

    /**
     * @param Request $request
     * @param Response $response
     * @param null $lifetimeInSeconds
     * @param array $tags
     */
    protected function makeReplacementsAndCacheResponse(
        Request $request,
        Response $response,
        $lifetimeInSeconds = null,
        array $tags = []
    ) {
        $cachedResponse = clone $response;

        $this->getReplacers()->each( function(IReplacer $replacer) use ($cachedResponse) {
            $replacer->prepareResponseToCache( $cachedResponse );
        } );

        $this->responseCache->cacheResponse( $request, $cachedResponse, $lifetimeInSeconds, $tags );
    }

    /**
     * @return Collection
     */
    protected function getReplacers() {
        return collect( config( 'core.response_cache.replacers' ) )
            ->map( function(string $replacerClass) {
                return app( $replacerClass );
            } );
    }

    /**
     * @param array $args
     *
     * @return int|null
     */
    protected function getLifetime(array $args) {
        if( count( $args ) >= 1 && is_numeric( $args[0] ) ) {
            return (int) $args[0];
        }

        return null;
    }

    /**
     * @param array $args
     *
     * @return array
     */
    protected function getTags(array $args) {
        $tags = $args;

        if( count( $args ) >= 1 && is_numeric( $args[0] ) ) {
            $tags = array_slice( $args, 1 );
        }

        return array_filter( $tags );
    }

}