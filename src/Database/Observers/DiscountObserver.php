<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Observers;


use Illuminate\Database\Eloquent\Model;

/**
 * Class DiscountObserver
 * @package PlusClouds\Core\Database\Observers
 */
class DiscountObserver extends AbstractObserver
{

    /**
     * @param Model $model
     */
    public function saving(Model $model) {
        // Eklenen/güncellenen verinin indirim tipi "fiyat" ise
        // "currency_code" girilmemiş veya değiştirilmiş ise, "locale"e göre ilgili kodu bulup değiştiriyoruz.
        if( $model->discount_type === registry( 'enum.discount.type.price' ) ) {
            if( empty( $model->currency_code ) || $model->isDirty( 'currency_code' ) ) {
                $model->currency_code = getLanguageByCode( app()->getLocale() )->currency_code;
            }
        }
    }

}