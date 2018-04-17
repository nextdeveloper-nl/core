<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Vinkla\Hashids\Facades\Hashids;

/**
 * Trait HashId
 * @package PlusClouds\Core\Database\Traits
 */
trait HashId
{

    /**
     *
     */
    public static function bootHashid() {
        static::created( function($model) {
            $model->attributes[ static::getHashidsColumn() ] = Hashids::connection( static::getHashidConnection( $model ) )
                ->encode( static::getHashidEncodingValue( $model ) );

            $dispatcher = $model->getEventDispatcher();

            $model->unsetEventDispatcher();
            $model->save();
            $model->setEventDispatcher( $dispatcher );
        } );
    }

    /**
     * @param Model $model
     *
     * @return string
     */
    public static function getHashidConnection(Model $model) {
        $key = 'hashids.table__'.$model->getTable();

        return config()->has( $key ) ? $key : 'main';
    }

    /**
     * @return string
     */
    public static function getHashidsColumn() {
        return 'id_ref';
    }

    /**
     * @param Model $model
     *
     * @return mixed
     */
    public static function getHashidEncodingValue(Model $model) {
        return $model->id;
    }

    /**
     * @param $ref
     * @param array $columns
     *
     * @return mixed
     */
    public static function findByRef($ref, $columns = [ '*' ]) {
        if( ! is_null( $data = static::whereRaw( static::getHashidsColumn().' = \''.$ref.'\' COLLATE utf8_bin' )->first( $columns ) ) ) {
            return $data;
        }

        throw new ModelNotFoundException;
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

}