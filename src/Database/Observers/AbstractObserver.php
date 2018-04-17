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
 * Class AbstractObserver
 * @package PlusClouds\Core\Database\Observers
 */
abstract class AbstractObserver
{

    /**
     * Veritabanından bir veri alındığında tetiklenir.
     *
     * @param Model $model
     */
    public function retrieved(Model $model){

    }

    /**
     * Bir veri kaydedilmeden önce tetiklenir.
     *
     * @param Model $model
     */
    public function creating(Model $model){

    }

    /**
     * Bir veri kaydedildikten sonra tetiklenir.
     *
     * @param Model $model
     */
    public function created(Model $model){

    }

    /**
     * Bir veri güncellenmeden önce tetiklenir.
     *
     * @param Model $model
     */
    public function updating(Model $model){

    }

    /**
     * Bir veri güncellendikten sonra tetiklenir.
     *
     * @param Model $model
     */
    public function updated(Model $model){

    }

    /**
     * Bir veri kaydedilmeden önce veya varolan bir veri
     * güncellenmeden önce tetiklenir.
     *
     * @param Model $model
     */
    public function saving(Model $model){

    }

    /**
     * Bir veri kaydedildikten sonra veya varolan bir veri
     * güncellendikten sonra tetiklenir.
     *
     * @param Model $model
     */
    public function saved(Model $model){

    }

    /**
     * Bir veri silinmeden önce tetiklenir.
     *
     * @param Model $model
     */
    public function deleting(Model $model){

    }

    /**
     * Bir veri silindikten sonra tetiklenir.
     *
     * @param Model $model
     */
    public function deleted(Model $model){

    }

    /**
     * Silinmiş beri geri alınmadan önce tetiklenir. (Softdelete)
     *
     * @param Model $model
     */
    public function restoring(Model $model){

    }

    /**
     * Silinmiş bir veri geri alındıktan sonra tetiklenir. (Softdelete)
     *
     * @param Model $model
     */
    public function restored(Model $model){

    }

}