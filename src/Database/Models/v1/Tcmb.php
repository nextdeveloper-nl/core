<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Models\v1;

use PlusClouds\Core\Database\Models\AbstractModel;

/**
 * Class Tcmb.
 *
 * @package PlusClouds\Core\Database\Models
 */
class Tcmb extends AbstractModel {
    protected $connection = 'migration';

    protected $table = 'tcmb';
}
