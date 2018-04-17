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

use PlusClouds\Core\Database\Traits\GlobalScopes\WithPassive;

/**
 * Class Language
 * @package PlusClouds\Core\Database\Models
 */
class Language extends AbstractModel
{

    use WithPassive;

    /**
     * @var bool
     */
    public $timestamps = false;

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @var array
     */
    protected $casts = [
        'is_default' => 'boolean',
        'is_active'  => 'boolean',
    ];

    /**
     * @param $query
     *
     * @return mixed
     */
    public function scopeDefault($query) {
        return $query->where( 'is_default', true );
    }

    /**
     * @param $query
     * @param $code
     *
     * @return mixed
     */
    public function scopeCode($query, $code) {
        return $query->where( 'code', strtoupper( $code ) );
    }

}