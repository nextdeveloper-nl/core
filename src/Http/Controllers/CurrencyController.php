<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Controllers;


use Illuminate\Database\Eloquent\ModelNotFoundException;
use PlusClouds\Core\Database\Models\Country;

/**
 * Class CurrencyController
 * @package PlusClouds\Core\Http\Controllers
 */
class CurrencyController extends AbstractController
{

    /**
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index() {
        $currencies = Country::all()->pluck( 'currency_code' );

        throw_if( $currencies->isEmpty(), ModelNotFoundException::class, 'Could not find the records you are looking for.' );

        return $this->withArray([
            'data' => $currencies->unique()->values()
        ]);
    }

}