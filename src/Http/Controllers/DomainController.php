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
use PlusClouds\Core\Database\Filters\DomainQueryFilter;
use PlusClouds\Core\Database\Models\Domain;
use PlusClouds\Core\Http\Requests\DomainStoreRequest;
use PlusClouds\Core\Http\Requests\DomainUpdateRequest;
use PlusClouds\Core\Http\Transformers\DomainTransformer;

class DomainController extends AbstractController
{

    /**
     * Alan adı listesini döndürür.
     *
     * @param DomainQueryFilter $filter
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index(DomainQueryFilter $filter) {
        $domains = Domain::filter( $filter )
            ->where( 'account_id', getAUCurrentAccount()->id )
            ->get();

        throw_if( $domains->isEmpty(), ModelNotFoundException::class, 'Could not find the records you are looking for.' );

        return $this->withCollection( $domains, app( DomainTransformer::class ) );
    }

    /**
     * Alan adı bilgisini döndürür.
     *
     * @param Domain $domain
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Domain $domain) {
        throw_if( $domain->account_id != getAUCurrentAccount()->id, ModelNotFoundException::class, 'Could not find the records you are looking for.' );

        return $this->withItem( $domain, app( DomainTransformer::class ) );
    }

    /**
     * Yeni bir alan adı oluşturur.
     *
     * @param DomainStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(DomainStoreRequest $request) {
        $domain = Domain::create( $request->validated() );

        return $this->setStatusCode( 201 )
            ->withItem( $domain->fresh(), app( DomainTransformer::class ) );
    }

    /**
     * Varolan alan adı bilgilerini günceller.
     *
     * @param DomainUpdateRequest $request
     * @param Domain $domain
     *
     * @return mixed
     */
    public function update(DomainUpdateRequest $request, Domain $domain) {
        $domain->update( $request->validated() );

        return $this->noContent();
    }

    /**
     * Varolan bir alan adını siler.
     *
     * @param Domain $domain
     *
     * @return mixed
     * @throws \Exception
     */
    public function destroy(Domain $domain) {
        $this->authorize( 'destroy', $domain );

        $domain->delete();

        return $this->noContent();
    }

}