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


use Illuminate\Cache\Repository;
use PlusClouds\Core\Common\Cache\ResponseCache\Serializers\ISerializable;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class ResponseCacheRepository
 * @package PlusClouds\Core\Common\Cache\ResponseCache
 */
class ResponseCacheRepository
{

    /** @var \Illuminate\Cache\Repository */
    protected $cache;

    /** @var ResponseSerializer */
    protected $responseSerializer;

    /**
     * ResponseCacheRepository constructor.
     *
     * @param ISerializable $responseSerializer
     * @param Repository $cache
     */
    public function __construct(ISerializable $responseSerializer, Repository $cache) {
        $this->cache = $cache;
        $this->responseSerializer = $responseSerializer;
    }

    /**
     * @param string $key
     * @param \Symfony\Component\HttpFoundation\Response $response
     * @param \DateTime|int $seconds
     */
    public function put(string $key, $response, $seconds) {
        $this->cache->put( $key, $this->responseSerializer->serialize( $response ), is_numeric( $seconds ) ? now()->addSeconds( $seconds ) : $seconds );
    }

    /**
     * @param string $key
     *
     * @return bool
     */
    public function has(string $key) : bool {
        return $this->cache->has( $key );
    }

    /**
     * @param string $key
     *
     * @return Response
     * @throws \PlusClouds\Core\Common\Cache\ResponseCache\Exceptions\CouldNotUnserialize
     */
    public function get(string $key) {
        return $this->responseSerializer->unserialize( $this->cache->get( $key ) );
    }

    /**
     * @return void
     */
    public function clear() {
        $this->cache->clear();
    }

    /**
     * @param string $key
     *
     * @return bool
     */
    public function forget(string $key) : bool {
        return $this->cache->forget( $key );
    }

    /**
     * @param array $tags
     *
     * @return ResponseCacheRepository
     */
    public function tags(array $tags) : self {
        return new self( $this->responseSerializer, $this->cache->tags( $tags ) );
    }

}