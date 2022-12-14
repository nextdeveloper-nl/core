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

use PlusClouds\Core\Database\Models\Address;
use PlusClouds\Core\Database\Models\Country;
use PlusClouds\Core\Http\Requests\Address\AddressStoreRequest;
use PlusClouds\Core\Http\Requests\Address\AddressUpdateRequest;

/**
 * Class AddressController
 * @package PlusClouds\Core\Http\Controllers
 */
class AddressController extends AbstractController
{
	/**
	 * Creates a new Address
	 *
	 * @param AddressStoreRequest $request
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 * @throws \PlusClouds\Core\Exceptions\ObjectNotFoundException
	 */
    public function store(AddressStoreRequest $request)
    {
        $data = $request->validated();

        $objectArr = findObjectFromClassName($data['object'], $data['object_id'], 'Addressable');

        $data = collect($data)->merge([
            'addressable_type' => $objectArr[0],
            'addressable_id' => $objectArr[1],
        ])->forget(['object', 'object_id'])->toArray();

        if ($request->has('country_id')) {
            $data = array_merge(
                $data,
                [
                    'country_id' => Country::where('id_ref', $request->get('country_id'))->first()->id
                ]
            );
        }

        Address::create($data);

        return $this->setStatusCode(202)->noContent();
    }

	/**
	 * @name Update an Address
	 *
	 * @param AddressUpdateRequest $request
	 * @param Address $address
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 */
    public function update(AddressUpdateRequest $request, Address $address)
    {
        $data = collect($request->validated())->forget(['addressable_id'])->toArray();

        if ($request->has('country_id')) {
            $data = array_merge(
                $data,
                [
                    'country_id' => Country::where('id_ref', $request->get('country_id'))->first()->id
                ]
            );
        }

        if ($request->get('is_invoice_address')) {

            optional($address->addressable)->removeInvoiceAddress();

        }

        $address->update($data);
        return $this->noContent();
    }


	/**
	 * @name Delete an Address
	 *
	 * @param Address $address
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 * @throws \Exception
	 */
    public function destroy(Address $address)
    {
        $address->delete();
        return $this->noContent();
    }
}
