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
use PlusClouds\Core\Database\Models\Hook;
use PlusClouds\Core\Http\Requests\HookStoreRequest;
use PlusClouds\Core\Http\Requests\HookUpdateRequest;
use PlusClouds\Core\Http\Resources\HookCollection;
use PlusClouds\Core\Http\Resources\HookResource;

/**
 * Class HookController
 * @package PlusClouds\Core\Http\Controllers
 */
class HookController extends AbstractController
{

    /**
     * Kanca listesini döndürür.
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index() {
        $hooks = Hook::all();

        throw_if( $hooks->isEmpty(), ModelNotFoundException::class, 'Could not find the records you are looking for.' );

        return $this->withCollection( HookCollection::make( $hooks ) );
    }

    /**
     * Kanca bilgisini döndürür.
     *
     * @param Hook $hook
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Hook $hook) {
        return $this->withItem( HookResource::make( $hook ) );
    }

    /**
     * Yeni bir kanca oluşturur.
     *
     * @param HookStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(HookStoreRequest $request) {
        // Eğer bir vendor'a bağlı oluşturulacaksa
        if( $request->has( 'account_ref' ) ) {
            if( class_exists( $class = 'PlusClouds\Account\Database\Models\Account' ) ) {
                $vendor = app( $class )->findByRef( $request->get( 'account_ref' ) );

                $request->merge( [ 'account_id' => $vendor->id ] );
            }
        }

        $hook = Hook::create( $request->except( [ 'account_ref' ] ) );

        return $this->setStatusCode( 201 )
            ->withItem( HookResource::make( $hook->fresh() ) );
    }

    /**
     * Varolan kanca bilgilerini günceller.
     *
     * @param HookUpdateRequest $request
     * @param Hook $hook
     *
     * @return mixed
     */
    public function update(HookUpdateRequest $request, Hook $hook) {
        $hook->update( $request->validated() );

        return $this->noContent();
    }

    /**
     * Varolan bir kancayı siler.
     *
     * @param Hook $hook
     *
     * @return mixed
     * @throws \Exception
     */
    public function delete(Hook $hook) {
        $hook->delete();

        // @todo: Gate gelecek;

        return $this->noContent();
    }

}