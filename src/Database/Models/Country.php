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

use PlusClouds\Core\Database\Traits\Filterable;
use PlusClouds\Core\Database\Traits\GlobalScopes\WithPassive;
use PlusClouds\Core\Database\Traits\UuidId;
use PlusClouds\Core\Exceptions\NotFoundException;

/**
 * Class Country.
 *
 * @package PlusClouds\Core\Database\Models
 */
class Country extends AbstractModel {
    use Filterable,WithPassive,UuidId;

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
    protected $appends = ['vat'];

    /**
     * @var array
     */
    protected $casts = [
        'phone_code' => 'integer',
        'rate'       => 'double',
        'is_active'  => 'boolean',
    ];

    /**
     * @return float
     */
    public function getVatAttribute() {
        return (float)$this->attributes['rate'];
    }

    /**
     * Ülke koduna göre kayıt getirir.
     *
     * @param $query
     * @param $code
     *
     * @return mixed
     */
    public function scopeCode($query, $code) {
        $code = strtoupper($code);

        $q = clone $query;

        if ($q->where('code', $code)->count() > 0) {
            return $query->where('code', $code);
        } else {
        	logger()->error('[CountryCode] Cannot find the code you have given or the country is not active');
        }

        return $query->where('code', config('core.country_resolver.default'));
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
	    $q = clone $query;

	    if ($q->where('locale', strtoupper($locale))->count() > 0) {
		    return $query->where('locale', strtoupper($locale));
	    } else {
	    	throw new NotFoundException('[CountryLocale] Cannot find the locale you have given or the country is not active');
	    }
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
        return $query->where('phone_code', $phoneCode);
    }
}
