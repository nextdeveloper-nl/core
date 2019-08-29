<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\Middlewares;


use Closure;
use Illuminate\Http\Request;
use Spatie\ResponseCache\Events\CacheMissed;
use Symfony\Component\HttpFoundation\Response;
use Spatie\ResponseCache\Events\ResponseCacheHit;
use PlusClouds\Core\Common\Cache\HttpCache\ResponseCache;

/**
 * Class CacheResponse
 * @package PlusClouds\Core\Common\Cache\Middlewares
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
     * @param null $lifetimeInMinutes
     *
     * @return Response
     */
    public function handle(Request $request, Closure $next, $lifetimeInMinutes = null) : Response {
        if( $this->responseCache->enabled( $request ) ) {
            if( $this->responseCache->hasBeenCached( $request ) ) {
                event( new ResponseCacheHit( $request ) );

                return $this->responseCache->getCachedResponseFor( $request );
            }
        }

        $response = $next( $request );

        if( $this->responseCache->enabled( $request ) ) {
            if( $this->responseCache->shouldCache( $request, $response ) ) {
                $this->responseCache->cacheResponse( $request, $response, $lifetimeInMinutes );
            }
        }

        event( new CacheMissed( $request ) );

        return $response;
    }
}