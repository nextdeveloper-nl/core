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
 * Class Country
 * @package PlusClouds\Core\Database\Models
 */
class Country extends AbstractModel
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
        'phone_code' => 'integer',
        'is_active'  => 'boolean',
    ];

    /**
     * Ülke koduna göre kayıt getirir.
     *
     * @param $query
     * @param $code
     *
     * @return mixed
     */
    public function scopeCode($query, $code) {
        return $query->where( 'code', strtoupper( $code ) );
    }

    /**
     * Yerelleştirme koduna göre kayıt getirir.
     *
     * @param $query
     * @param $locale
     *
     * @return mixed
     */
    public function scopeLocale($query, $locale) {
        return $query->where( 'locale', strtoupper( $locale ) );
    }

    /**
     * Ülke telefon koduna göre kayıt getirir.
     *
     * @param $query
     * @param $phoneCode
     *
     * @return mixed
     */
    public function scopePhoneCode($query, $phoneCode) {
        return $query->where( 'phone_code', $phoneCode );
    }

}