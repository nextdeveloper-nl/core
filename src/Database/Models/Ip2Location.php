<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Models;


/**
 * Class Ip2Location
 * @package PlusClouds\Core\Database\Models
 */
class Ip2Location extends AbstractModel
{

    public $table = 'ip2location';

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @param $query
     * @param string $ipAddr
     *
     * @return mixed
     */
    public function scopeResolve($query, $ipAddr) {
        return $query->where( 'ip_from', '<', ip2long( $ipAddr ) )
            ->where( 'ip_to', '>', ip2long( $ipAddr ) );
    }

}