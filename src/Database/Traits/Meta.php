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

use Phoenix\EloquentMeta\MetaTrait;

/**
 * Trait Meta
 * @package PlusClouds\Core\Database\Traits
 */
trait Meta
{

    use MetaTrait {
        getMeta as protected _getMeta;
        deleteMeta as protected _deleteMeta;
        addMeta as protected _addMeta;
        updateMeta as protected _updateMeta;
        appendMeta as protected _appendMeta;
    }

    /**
     * @param string $key
     *
     * @return bool
     */
    public function hasMeta($key) {
        [ , $realKey, $meta ] = $this->getDottedItem( $key );

        $result = false;

        if( $meta ) {
            $result = array_has( $meta, $realKey );
        } else {
            if( $this->_getMeta( $key ) ) {
                $result = true;
            }
        }

        return $result;
    }

    /**
     * @param string $key
     * @param null|mixed $default
     * @param bool $getObj
     *
     * @return \Illuminate\Support\Collection|mixed|null
     */
    public function getMeta($key, $default = null, $getObj = false) {
        [ , $realKey, $meta ] = $this->getDottedItem( $key );

        if( $meta ) {
            $data = array_get( $meta, $realKey );

            if( is_array( $data ) ) {
                $collection = collect();

                foreach( $data as $key => $value ) {
                    $collection->put( $key, $value );
                }

                $data = json_decode( $collection->toJson( JSON_FORCE_OBJECT ) );
            }

            return $data ?? $default;
        } else {
            return $this->_getMeta( $key, $default, $getObj );
        }
    }

    /**
     * @param string $key
     * @param mixed $value
     *
     * @return mixed
     */
    public function deleteMeta($key, $value = false) {
        [ $baseKey, $realKey, $meta ] = $this->getDottedItem( $key );

        if( $meta ) {
            array_forget( $meta, $realKey );

            if( empty( $meta ) ) {
                return $this->_deleteMeta( $baseKey, $value );
            }

            return $this->_updateMeta( $baseKey, $meta );

        } else {
            return $this->_deleteMeta( $key, $value );
        }
    }

    /**
     * @param string $key
     * @param mixed $value
     *
     * @return bool|mixed
     */
    public function addMeta($key, $value) {
        [ $baseKey, $realKey, $meta ] = $this->getDottedItem( $key );

        if( $meta ) {
            if( array_has( $meta, $realKey ) ) {
                return false;
            }

            array_set( $meta, $realKey, $value );

            return $this->_updateMeta( $baseKey, $meta );
        } else {
            return $this->_addMeta( $key, $value );
        }
    }

    /**
     * @param string $key
     * @param mixed $newValue
     * @param mixed $oldValue
     *
     * @return mixed|null
     */
    public function updateMeta($key, $newValue, $oldValue = false) {
        [ $baseKey, $realKey, $meta ] = $this->getDottedItem( $key );

        if( $meta ) {
            array_set( $meta, $realKey, $newValue );

            return $this->_updateMeta( $baseKey, $meta, $oldValue );
        } else {
            return $this->_updateMeta( $key, $newValue, $oldValue );
        }
    }

    /**
     * @param string $key
     * @param mixed $value
     *
     * @return mixed
     */
    public function appendMeta($key, $value) {
        [ $baseKey, $realKey, $meta ] = $this->getDottedItem( $key );

        if( $meta ) {
            array_set( $meta, $realKey, $value );

            return $this->_updateMeta( $baseKey, $meta );
        } else {
            return $this->_appendMeta( $key, $value );
        }
    }

    /**
     * @param string $key
     *
     * @return array
     */
    private function getDottedItem($key) {
        if( str_contains( $key, '.' ) ) {
            $keys = explode( '.', $key );
            $realKey = implode( '.', array_except( $keys, [ 0 ] ) );
            $meta = $this->getMeta( ( $baseKey = head( $keys ) ) );

            return [
                $baseKey,
                $realKey,
                json_decode( json_encode( $meta, JSON_FORCE_OBJECT ), true ) // recursive object to array
            ];
        }

        return [ null, $key, null ];
    }

}