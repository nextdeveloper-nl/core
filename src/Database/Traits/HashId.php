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
 * Trait HashId.
 *
 * @package PlusClouds\Core\Database\Traits
 */
trait HashId {
    /**
     * return @void.
     */
    public static function bootHashid() {
        static::created(function ($model) {
            $model->attributes[static::getHashidsColumn()] = Hashids::connection(static::getHashidConnection($model))
                ->encode(static::getHashidEncodingValue($model));

            $dispatcher = $model->getEventDispatcher();

            $model->unsetEventDispatcher();
            $model->save();
            $model->setEventDispatcher($dispatcher);
        });
    }

    /**
     * @param Model $model
     *
     * @return string
     */
    public static function getHashidConnection(Model $model) {
        $key = 'hashids.connections.table__'.$model->getTable();

        return config()->has($key) ? 'table__'.$model->getTable() : 'main';
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
     *
     * @throws ModelNotFoundException
     *
     * @return mixed
     */
    public static function findByRef($ref) {
        if ( ! is_null($data = static::whereRaw(static::getHashidsColumn().' COLLATE utf8_bin = ?', [$ref])->first())) {
            return $data;
        }

        // if ( ! is_null($data = static::whereRaw(static::getHashidsColumn().' = \''.$ref.'\' COLLATE utf8_bin')->first())) {
        //     return $data;
        // }

        $className = str_replace('_', ' ', snake_case(camel_case(class_basename(static::class))));

        $message = sprintf('Could not find any %s', $className);

        throw new ModelNotFoundException($message);
    }

    /**
     * @param $query
     * @param $ref
     *
     * @return mixed
     */
    public function scopeByRef($query, $ref) {
        return $query->whereRaw(static::getHashidsColumn().' COLLATE utf8_bin = ?', [$ref]);

        // return $query->whereRaw(static::getHashidsColumn().' = \''.$ref.'\' COLLATE utf8_bin');
    }
}
