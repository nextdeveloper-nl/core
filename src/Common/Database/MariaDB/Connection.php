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


use \Illuminate\Database\MySqlConnection;

/**
 * Class Connection
 * @package PlusClouds\Core\Common\Database\MariaDB
 */
class Connection extends MySqlConnection
{

    /**
     * @return \Illuminate\Database\Grammar|\Illuminate\Database\Schema\Grammars\MySqlGrammar
     */
    protected function getDefaultSchemaGrammar() {
        return $this->withTablePrefix( new SchemaGrammar );
    }

    /**
     * @return \Illuminate\Database\Grammar|\Illuminate\Database\Query\Grammars\MySqlGrammar
     */
    protected function getDefaultQueryGrammar() {
        return $this->withTablePrefix( new QueryGrammar );
    }

}