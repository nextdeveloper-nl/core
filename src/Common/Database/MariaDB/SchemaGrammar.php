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


use Illuminate\Support\Fluent;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Schema\Grammars\MySqlGrammar;

/**
 * Class SchemaGrammar
 * @package PlusClouds\Core\Common\Database\MariaDB
 */
class SchemaGrammar extends MySqlGrammar
{

    /**
     * SchemaGrammar constructor.
     */
    public function __construct() {
        if( ! in_array( 'Check', $this->modifiers ) ) {
            array_splice(
                $this->modifiers,
                array_search( 'After', $this->modifiers ),
                count( $this->modifiers ),
                array_merge( [ 'Check' ], array_slice( $this->modifiers, array_search( 'After', $this->modifiers ) ) )
            );
        }
    }

    /**
     * @param Blueprint $blueprint
     * @param Fluent $column
     *
     * @return string
     */
    protected function modifyCheck(Blueprint $blueprint, Fluent $column) {
        if( $this->getType( $column ) == 'json' ) {
            return sprintf( ' CHECK (%sJSON_VALID(%s))',
                $column->nullable ? ( $this->wrap( $column->name ).' IS NULL OR ' ) : '',
                $this->wrap( $column->name )
            );
        }
    }

}