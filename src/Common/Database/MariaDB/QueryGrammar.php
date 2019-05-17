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


use Illuminate\Support\Str;
use Illuminate\Database\Query\Grammars\MySqlGrammar;

/**
 * Class QueryGrammar
 * @package PlusClouds\Core\Common\Database\MariaDB
 */
class QueryGrammar extends MySqlGrammar
{

    /**
     * @param string $value
     *
     * @return string
     */
    protected function wrapJsonSelector($value) {
        if( Str::contains( $value, '->>' ) ) {
            $delimiter = '->>';
            $format = 'JSON_UNQUOTE(JSON_EXTRACT(%s, \'$.%s\'))';
        } else {
            $delimiter = '->';
            $format = 'JSON_EXTRACT(%s, \'$.%s\')';
        }

        $path = explode( $delimiter, $value );

        $field = collect( explode( '.', array_shift( $path ) ) )->map( function($part) {
            return $this->wrapValue( $part );
        } )->implode( '.' );

        return sprintf( $format, $field, collect( $path )->map( function($part) {
            return '"'.$part.'"';
        } )->implode( '.' ) );
    }

    //make table.field->json selects work

    /**
     * @param \Illuminate\Database\Query\Expression|string $value
     * @param bool $prefixAlias
     *
     * @return string
     */
    public function wrap($value, $prefixAlias = false) {
        $mysqlWrap = parent::wrap( $value, $prefixAlias );

        if( Str::contains( $mysqlWrap, '.JSON_EXTRACT' ) ) {
            if( Str::contains( $value, '->>' ) ) {
                $delimiter = '->>';
                $format = 'JSON_UNQUOTE(JSON_EXTRACT(%s, \'$.%s\'))';
            } else {
                $delimiter = '->';
                $format = 'JSON_EXTRACT(%s, \'$.%s\')';
            }

            $path = explode( $delimiter, $value );

            $field = collect( explode( '.', array_shift( $path ) ) )->map( function($part) {
                return $this->wrapValue( $part );
            } )->implode( '.' );

            return sprintf( $format, $field, collect( $path )->map( function($part) {
                return '"'.$part.'"';
            } )->implode( '.' ) );
        }

        return $mysqlWrap;
    }

}