<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Yunus Çelik <yunus.celik@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;

use Illuminate\Database\Eloquent\ModelNotFoundException;

/**
 * Trait UuidId
 * @package PlusClouds\Core\Database\Traits
 */
trait UuidId
{
    /**
     * @return string
     */
    public static function getHashidsColumn() {
        return 'id_ref';
    }   

    /**
     * @param $ref
     *
     * @return mixed
     * @throws ModelNotFoundException
     */
    public static function findByRef($ref) {
        if( ! is_null( $data = static::whereRaw( static::getHashidsColumn().' = \''.$ref.'\' COLLATE utf8_bin' )->first() ) ) {
            return $data;
        }

        $className = str_replace( '_', ' ', snake_case( camel_case( class_basename( static::class ) ) ) );

        $message = sprintf( 'Could not find any %s', $className );

        throw new ModelNotFoundException( $message );
    }

    /**
     * @param $ref
     */
    public static function findByUuid($ref) {
        return static::findByRef($ref);
    }

    /**
     * @param $query
     * @param $ref
     *
     * @return mixed
     */
    public function scopeByRef($query, $ref) {
        return $query->whereRaw( static::getHashidsColumn().' = \''.$ref.'\' COLLATE utf8_bin' );
    }

    /**
     * @param $query
     * @param $ref
     */
    public function scopeByUuid($query, $ref) {
        return $this->scopeByRef($query, $ref);
    }
}