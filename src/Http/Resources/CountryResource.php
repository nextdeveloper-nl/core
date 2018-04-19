<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Resources;


/**
 * Class CountryResource
 * @package PlusClouds\Core\Http\Resources
 */
class CountryResource extends AbstractResource
{

    /**
     * @param \Illuminate\Http\Request $request
     *
     * @return array
     */
    public function toArray($request) {
        return $this->filterFields( [
            'code'                => $this->code,
            'locale'              => $this->locale,
            'name'                => $this->name,
            'currency_code'       => $this->currency_code,
            'phone_code'          => $this->phone_code,
            'tax_rate'            => $this->rate,
            'tax_rate_percentage' => $this->percentage,
            'continent_name'      => $this->continent_name,
            'continent_code'      => $this->continent_code,
        ] );
    }

}