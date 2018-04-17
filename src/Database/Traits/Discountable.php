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

use PlusClouds\Core\Database\Models\Discount;

/**
 * Trait Discountable
 * @package PlusClouds\Core\Database\Traits
 */
trait Discountable
{

    /**
     * Aktif indirimleri dönrürü.
     *
     * @return mixed
     */
    public function discounts() {
        $whereClause = preg_replace( '/\s+/', ' ', str_replace( "\n", " ",
            "CASE WHEN
                ( discounts.`start_at` IS NULL AND discounts.`expires_at` IS NULL ) AND
                ( discountables.`custom_start_at` IS NULL AND discountables.`custom_expires_at` IS NULL ) THEN
                TRUE
            ELSE CASE
                WHEN ( discountables.`custom_start_at` IS NOT NULL AND discountables.`custom_expires_at` IS NOT NULL ) THEN
                    ( discountables.`custom_start_at` <= NOW() AND discountables.`custom_expires_at` >= NOW() )
                ELSE
                    ( discounts.`start_at` <= NOW() AND discounts.`expires_at` >= NOW() )
                END
            END"
        ) );

        return $this->morphToMany( Discount::class, 'discountable' )
            ->withPivot( [ 'custom_start_at', 'custom_expires_at' ] )
            ->withTimestamps()
            ->whereRaw( $whereClause );
    }

    /**
     * En son eklenmiş indirimi getirir.
     *
     * @return mixed
     */
    public function latestDiscount() {
        return $this->discounts()->orderBy( 'id', 'DESC' )->first();
    }

    /**
     * Yeni bir indirim yaratır.
     *
     * @param array $data
     * @param array $fields
     *
     * @return mixed
     */
    public function createDiscount($data, $fields = []) {
        $discount = Discount::firstOrCreate( $data );

        if( ! $this->discounts->contains( $discount->getKey() ) ) {
            $this->discounts()->attach( $discount->getKey(), $fields );
        }

        return $this->load( 'discounts' );
    }

    /**
     * Yeni bir indirim ekler.
     *
     * @param int|string $discount
     * @param array $fields
     *
     * @return mixed
     */
    public function addDiscount($discount, $fields = []) {
        if( ! $discount instanceof Discount ) {
            if( is_string( $discount ) ) {
                $discount = Discount::findByRef( $discount );
            } else {
                $discount = Discount::find( $discount );
            }
        }

        if( $discount && ! $this->discounts->contains( $discount->getKey() ) ) {
            $this->discounts()->attach( $discount->getKey(), $fields );
        }

        return $this->load( 'discounts' );
    }

    /**
     * Varolan bir indirimi siler.
     *
     * @param int|string $discount
     *
     * @return $this
     */
    public function deleteDiscount($discount) {
        if( ! $discount instanceof Discount ) {
            if( is_string( $discount ) ) {
                $discount = Discount::withPassive()->findByRef( $discount );
            } else {
                $discount = Discount::withPassive()->find( $discount );
            }
        }

        if( $discount && $this->discounts->contains( $discount->getKey() ) ) {
            $this->discounts()->detach( $discount );
        }

        return $this->load( 'discounts' );
    }

    /**
     * Tanımlanmış bütün indirimleri siler.
     *
     * @return $this
     */
    public function removeAllDiscounts() {
        $this->discounts()->sync( [] );

        return $this->load( 'discounts' );
    }

}