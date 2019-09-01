<?php
/**
 * This file is part of the PlusClouds-5.5 library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\Hasher;


use Illuminate\Http\Request;
use PlusClouds\Core\Common\Cache\ResponseCache\CacheProfiles\ICacheProfile;

/**
 * Class DefaultHasher
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Hasher
 */
class DefaultHasher implements IRequestHasher
{

    /** @var ICacheProfile */
    protected $cacheProfile;

    /**
     * DefaultHasher constructor.
     *
     * @param ICacheProfile $cacheProfile
     */
    public function __construct(ICacheProfile $cacheProfile) {
        $this->cacheProfile = $cacheProfile;
    }

    /**
     * @param Request $request
     *
     * @return string
     */
    public function getHashFor(Request $request) : string {
        return 'responsecache-'.md5(
                "{$request->getHost()}-{$request->getRequestUri()}-{$request->getMethod()}/".$this->cacheProfile->useCacheNameSuffix( $request )
            );
    }

}