<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Filters;


use PlusClouds\Core\Database\GlobalScopes\ActiveScope;

/**
 * Class CountryQueryFilter
 * @package PlusClouds\Core\Database\Filters
 */
class CountryQueryFilter extends AbstractQueryFilter
{

    /**
     * @name Filter by continent code
     * @description ....
     * @param $code
     *
     * @return mixed
     */
    public function continentCode($code) {
        return $this->builder->where( 'continent_code', strtoupper( $code ) );
    }

    /**
     * @return mixed
     */
    public function passive() {
        return $this->builder->withoutGlobalScope( ActiveScope::class )
            ->where( 'is_active', false );
    }

	/**
	 * Filters the country with phone code
	 *
	 * @param $phoneCode
	 * @return \Illuminate\Database\Eloquent\Builder
	 */
    public function phoneCode($phoneCode) {
    	return $this->builder->where('phone_code', $phoneCode);
    }
}