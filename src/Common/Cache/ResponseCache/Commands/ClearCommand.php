<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\Commands;


use Illuminate\Console\Command;
use PlusClouds\Core\Common\Cache\ResponseCache\ResponseCacheRepository;
use PlusClouds\Core\Common\Cache\ResponseCache\Events\ClearedResponseCache;
use PlusClouds\Core\Common\Cache\ResponseCache\Events\ClearingResponseCache;

/**
 * Class ClearCommand
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Commands
 */
class ClearCommand extends Command
{

    /**
     * @var string
     */
    protected $signature = 'response_cache:clear';

    /**
     * @var string
     */
    protected $description = 'Clear the response cache';

    /**
     * @param ResponseCacheRepository $cache
     */
    public function handle(ResponseCacheRepository $cache) {
        event( new ClearingResponseCache() );

        $cache->clear();

        event( new ClearedResponseCache() );

        $this->info( 'Response cache cleared!' );
    }

}