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
use Illuminate\Http\Request;
use PlusClouds\Core\Database\Models\Address;
use PlusClouds\Core\Http\Requests\Address\AddressStoreRequest;
use PlusClouds\Core\Http\Requests\Address\AddressUpdateRequest;

/**
 * Class AddressController
 * @package PlusClouds\Core\Http\Controllers
 */
class AddressController extends AbstractController
{

    public function store(AddressStoreRequest $request)
    {

        $data = $request->validated();

        $objectArr = findObjectFromClassName($data['object'], $data['object_id'], 'Addressable');


        Address::create(collect($request->validated())->merge([
            'addressable_type' => $objectArr[0],
            'addressable_id'   => $objectArr[1],
        ])->forget(['object','object_id'])->toArray());

        return $this->noContent();
    }

    public function update(AddressUpdateRequest $request,Address $address)
    {

        $address->update(collect($request->validated())->forget(['addressable_id'])->toArray());
        return $this->noContent();
    }


    public function destroy(Address $address)
    {
        $address->delete();
        return $this->noContent();
    }
}