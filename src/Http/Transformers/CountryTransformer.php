<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Transformers;


use PlusClouds\Core\Database\Models\Country;

/**
 * Class CountryTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class CountryTransformer extends AbstractTransformer
{

    /**
     * @var array
     */
    protected $visible = [ 'code', 'name', 'locale', 'currency_code', 'phone_code' ];

    /**
     * @param Country $country
     *
     * @return array
     */
    public function transform(Country $country) {
        return $this->buildPayload( [
            'code'           => $country->code,
            'name'           => $country->name,
            'locale'         => $country->locale,
            'currency_code'  => $country->currency_code,
            'phone_code'     => $country->phone_code,
            'continent_name' => $country->continent_name,
            'continent_code' => $country->continent_code,
            'geo_name_id'    => $country->geo_name_id,
            'active'         => $country->is_active,
        ] );
    }

}