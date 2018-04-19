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
use PlusClouds\Core\Http\Resources\CountryCollection;
use PlusClouds\Core\Http\Resources\CountryResource;

/**
 * Class CountryController
 * @package PlusClouds\Core\Http\Controllers
 */
class CountryController extends AbstractController
{

    /**
     * Ülke listesini döndürür.
     *
     * @param CountryQueryFilter $filter
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index(CountryQueryFilter $filter) {
        $countries = Country::filter( $filter )->get();

        throw_if( $countries->isEmpty(), ModelNotFoundException::class, 'Could not find the records you are looking for.' );

        return $this->withCollection( CountryCollection::make( $countries ) );
    }

    /**
     * Ülke bilgisini döndürür.
     *
     * @param Country $country
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Country $country) {
        return $this->withItem( CountryResource::make( $country ) );
    }

    /**
     * // Yeni bir ülke oluşturur.
     *
     * @param CountryStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(CountryStoreRequest $request) {
        $country = Country::create( $request->validated() );

        return $this->setStatusCode( 201 )
            ->withItem( CountryResource::make( $country->fresh() ) );
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
    public function destroy(Country $country){
        $country->delete();

        // todo: Gate gelecek

        return $this->noContent();
    }

}