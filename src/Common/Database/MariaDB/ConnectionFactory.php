<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Database\MariaDB;


use Illuminate\Database\Connectors\MySqlConnector;

/**
 * Class ConnectionFactory
 * @package PlusClouds\Core\Common\Database\MariaDB
 */
class ConnectionFactory extends \Illuminate\Database\Connectors\ConnectionFactory
{

    /**
     * @param array $config
     *
     * @return \Illuminate\Database\Connectors\ConnectorInterface|MySqlConnector
     */
    public function createConnector(array $config) {
        return new MySqlConnector;
    }

    /**
     * @param string $driver
     * @param \Closure|\PDO $connection
     * @param string $database
     * @param string $prefix
     * @param array $config
     *
     * @return \Illuminate\Database\Connection|Connection
     */
    protected function createConnection($driver, $connection, $database, $prefix = '', array $config = []) {
        return new Connection( $connection, $database, $prefix, $config );
    }

}