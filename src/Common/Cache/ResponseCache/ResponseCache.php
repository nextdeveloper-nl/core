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


use Illuminate\Http\Request;
use PlusClouds\Core\Common\Cache\ResponseCache\CacheProfiles\ICacheProfile;
use PlusClouds\Core\Common\Cache\ResponseCache\Hasher\IRequestHasher;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class ResponseCache
 * @package PlusClouds\Core\Common\Cache\ResponseCache
 */
class ResponseCache
{

    /** @var ResponseCacheRepository */
    protected $cache;

    /** @var IRequestHasher */
    protected $hasher;

    /** @var ICacheProfile */
    protected $cacheProfile;

    /**
     * ResponseCache constructor.
     *
     * @param ResponseCacheRepository $cache
     * @param IRequestHasher $hasher
     * @param ICacheProfile $cacheProfile
     */
    public function __construct(ResponseCacheRepository $cache, IRequestHasher $hasher, ICacheProfile $cacheProfile) {
        $this->cache = $cache;
        $this->hasher = $hasher;
        $this->cacheProfile = $cacheProfile;
    }

    /**
     * @param Request $request
     *
     * @return bool
     */
    public function enabled(Request $request) : bool {
        return $this->cacheProfile->enabled( $request );
    }

    /**
     * @param Request $request
     * @param Response $response
     *
     * @return bool
     */
    public function shouldCache(Request $request, Response $response) : bool {
        if( $request->attributes->has( 'response_cache.doNotCache' ) ) {
            return false;
        }

        if( ! $this->cacheProfile->shouldCacheRequest( $request ) ) {
            return false;
        }

        return $this->cacheProfile->shouldCacheResponse( $response );
    }

    /**
     * @param Request $request
     * @param Response $response
     * @param int|null $lifetimeInSeconds
     * @param array $tags
     *
     * @return Response
     */
    public function cacheResponse(
        Request $request,
        Response $response,
        $lifetimeInSeconds = null,
        array $tags = []
    ) {
        if( config( 'core.response_cache.add_cache_time_header' ) ) {
            $response = $this->addCachedHeader( $response );
        }

        $this->taggedCache( $tags )->put(
            $this->hasher->getHashFor( $request ),
            $response,
            $lifetimeInSeconds ?? $this->cacheProfile->cacheRequestUntil( $request )
        );

        return $response;
    }

    /**
     * @param Request $request
     * @param array $tags
     *
     * @return bool
     */
    public function hasBeenCached(Request $request, array $tags = []) : bool {
        return config( 'core.response_cache.enabled' )
            ? $this->taggedCache( $tags )->has( $this->hasher->getHashFor( $request ) )
            : false;
    }

    /**
     * @param Request $request
     * @param array $tags
     *
     * @return Response
     */
    public function getCachedResponseFor(Request $request, array $tags = []) : Response {
        return $this->taggedCache( $tags )->get( $this->hasher->getHashFor( $request ) );
    }

    /**
     * @param array $tags
     */
    public function clear(array $tags = []) {
        $this->taggedCache( $tags )->clear();
    }

    /**
     * @param Response $response
     *
     * @return Response
     */
    protected function addCachedHeader(Response $response) : Response {
        $clonedResponse = clone $response;
        $clonedResponse->headers->set(
            config( 'core.response_cache.cache_time_header_name' ),
            now()->toRfc2822String()
        );

        return $clonedResponse;
    }

    /**
     * @param string|array $uris
     * @param string[] $tags
     *
     * @return ResponseCache
     */
    public function forget($uris, array $tags = []) {
        $uris = is_array( $uris ) ? $uris : func_get_args();

        collect( $uris )->each( function($uri) use ($tags) {
            $request = Request::create( url( $uri ) );
            $hash = $this->hasher->getHashFor( $request );

            if( $this->taggedCache( $tags )->has( $hash ) ) {
                $this->taggedCache( $tags )->forget( $hash );
            }
        } );

        return $this;
    }

    /**
     * @param array $tags
     *
     * @return ResponseCacheRepository
     */
    protected function taggedCache(array $tags = []) {
        if( empty( $tags ) ) {
            return $this->cache;
        }

        return $this->cache->tags( $tags );
    }

}