<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Logger;

use Illuminate\Container\Container;
use Illuminate\Database\Events\QueryExecuted;

class QueryLogger {
    /**
     * @var Container
     */
    private $container;

    /**
     * @var PlusClouds\Core\Helpers\DebugMode
     */
    private $logger;

    /**
     * @param Container $container
     *
     * @return void
     */
    public function __construct(Container $container) {
        $this->container = $container;
        $this->logger = $container->make('QueryLogger');
    }

    /**
     * @param QueryExecuted $query
     *
     * @return void
     */
    public function handle(QueryExecuted $query) {
        if ( ! $this->container->get('app')->isLocal()) {
            return;
        }

        if ( ! (bool)$this->container->get('config')->get('core.log.query_logger')) {
            return;
        }

        $this->logger->debug("{$query->connection->getName()}: ", [
            'query'    => $this->getSqlWithBindings($query),
            'bindings' => $query->bindings,
            'time'     => $query->time.'ms',
        ]);
    }

    /**
     * @param QueryExecuted $query
     *
     * @return string
     */
    protected function getSqlWithBindings(QueryExecuted $query) : string {
        $sql = str_replace(['%', '?'], ['%%', '%s'], $query->sql);

        $handledBindings = array_map(function ($binding) {
            return is_numeric($binding)
                ? $binding
                : "'".str_replace(['\\', "'"], ['\\\\', "\'"], $binding)."'";
        }, $query->connection->prepareBindings($query->bindings));

        return vsprintf($sql, $handledBindings);
    }
}
