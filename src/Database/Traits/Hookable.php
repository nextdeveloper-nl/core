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

use PlusClouds\Core\Database\Models\Hook;

/**
 * Trait Hookable
 * @package PlusClouds\Core\Database\Traits
 */
trait Hookable
{

    /**
     * @return mixed
     */
    public function hooks() {
        return $this->morphToMany( Hook::class, 'hookable' )
            ->orderBy( 'hooks.position', 'ASC' )
            ->withTimestamps();
    }

    /**
     * @param array $data
     *
     * @return mixed
     */
    public function createHook($data) {
        $hook = Hook::firstOrCreate( $data );

        if( ! $this->hooks->contains( $hook->getKey() ) ) {
            $this->hooks()->attach( $hook->getKey() );
        }

        return $this->load( 'hooks' );
    }

    /**
     * @param int|array|Hook $hooks
     *
     * @return mixed
     */
    public function addHook($hooks) {
        if( ! is_array( $hooks ) ) {
            $hooks = (array) $hooks;
        }

        foreach( $hooks as $hook ) {
            if( ! $hook instanceof Hook ) {
                $hook = Hook::find( $hook );
            }

            if( $hook && ! $this->hooks->contains( $hook->getKey() ) ) {
                $this->hooks()->attach( $hook->getKey() );
            }

        }

        return $this->load( 'hooks' );
    }

    /**
     * @param int|array|Hook $hooks
     *
     * @return mixed
     */
    public function updateHook($hooks) {
        if( ! is_array( $hooks ) ) {
            $hooks = (array) $hooks;
        }

        foreach( $hooks as $hook ) {
            if( ! $hook instanceof Hook ) {
                $hook = Hook::find( $hook );
            }

            if( $hook && ! $this->hooks->contains( $hook->getKey() ) ) {
                $this->hooks()->detach( $hook->getKey() );
            }
        }

        return $this->load( 'hooks' );
    }

    /**
     * @param int|array|Hook $hooks
     *
     * @return mixed
     */
    public function deleteHook($hooks) {
        if( ! is_array( $hooks ) ) {
            $hooks = (array) $hooks;
        }

        foreach( $hooks as $hook ) {
            if( ! $hook instanceof Hook ) {
                $hook = Hook::find( $hook );
            }

            if( $hook && $this->hooks->contains( $hook->getKey() ) ) {
                $this->hooks()->detach( $hook->getKey() );
            }
        }

        return $this->load( 'hooks' );
    }

    /**
     * @return mixed
     */
    public function removeAllHooks() {
        $this->hooks()->sync( [] );

        return $this->load( 'hooks' );
    }

}