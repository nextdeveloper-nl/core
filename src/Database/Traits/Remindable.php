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
use Carbon\Carbon;

/**
 * Trait .
 *
 * @package PlusClouds\Core\Database\Traits
 */
trait Remindable
{

    /**
     * Adres bilgilerini döndürür.
     *
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function remindables()
    {

        return $this->morphMany('\PlusClouds\Core\Database\Models\Remindable', 'remindable', 'remindable_object_type');
    }


    public function remind($dateTime = null, $note = null)
    {
        return $this->remindables()->create([
            'note' => $note,
            'status' => 0,
            'remind_datetime' => $dateTime ?: Carbon::tomorrow(),
            'user_id' => getAUUser()->id
        ]);
    }

}
