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

class HookObserver extends AbstractObserver
{

    public function creating(Model $model) {
        // Eğer sıra belirtilmemişse, otomatik sıra numarası alıyoruz.
        if( is_null( $model->position ) ) {
            $model->position = $model::position();
        }
    }


}