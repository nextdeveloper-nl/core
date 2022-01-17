<?php
/**
 * This file is part of the PlusClouds.Account library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Models;

use Illuminate\Database\Eloquent\Model;
use PlusClouds\Core\Database\Observers\AbstractObserver;

/**
 * Class AddressObserver
 * @package PlusClouds\Account\Database\Models
 */
class AddressObserver extends AbstractObserver
{

    /**
     * @param Model $model
     */
    public function updating(Model $model)
    {
        if ($model->is_invoice_address) {
            optional($model->addressable)->removeInvoiceAddress();
        }
    }
}
