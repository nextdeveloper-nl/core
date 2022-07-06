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
use PlusClouds\Core\Database\Filters\CountryQueryFilter;
use PlusClouds\Core\Database\Models\Country;
use PlusClouds\Core\Http\Requests\CountryStoreRequest;
use PlusClouds\Core\Http\Requests\CountryUpdateRequest;
use PlusClouds\Core\Http\Transformers\CountryTransformer;

/**
 * Class CountryController
 * @package PlusClouds\Core\Http\Controllers
 */
class CountryController extends AbstractController
{

    /**
     * @name List Countries
     * @description Ülke listesini döndürür.
     *
     * @param CountryQueryFilter $filter
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index(CountryQueryFilter $filter) {
        $countries = Country::filter( $filter )->get();

        throw_if( $countries->isEmpty(), ModelNotFoundException::class, 'Could not find the country you are looking for. Are you making a typo OR! a new country may have been established and we dont know about that!' );

        return $this->withCollection( $countries, app( CountryTransformer::class ) );
    }

    /**
     * Returns country specific information stated in the API.
     *
     * @param Country $country
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Country $country) {
        return $this->withItem( $country, app( CountryTransformer::class ) );
    }

    /**
     * Creates a new country within the API.
     *
     * @param CountryStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(CountryStoreRequest $request) {
        $country = Country::create( $request->validated() );

        return $this->setStatusCode( 201 )
            ->withItem( $country->fresh(), app( CountryTransformer::class ) );
    }

    /**
     * Varolan ülke bilgilerini günceller.
     *
     * @param CountryUpdateRequest $request
     * @param Country $country
     *
     * @return mixed
     */
    public function update(CountryUpdateRequest $request, Country $country) {
        $country->update( $request->validated() );

        return $this->noContent();
    }

    /**
     * Varolan bir ülkeyi siler.
     *
     * @param Country $country
     *
     * @return mixed
     * @throws \Exception
     */
    public function destroy(Country $country) {
        $this->authorize( 'destroy', $country );

        $country->delete();

        return $this->noContent();
    }

}