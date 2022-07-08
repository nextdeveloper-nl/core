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
use PlusClouds\Core\Database\Filters\DomainQueryFilter;
use PlusClouds\Core\Database\Filters\GiftCodesQueryFilter;
use PlusClouds\Core\Database\Models\Domain;
use PlusClouds\Core\Database\Models\GiftCode;
use PlusClouds\Core\Http\Requests\DomainStoreRequest;
use PlusClouds\Core\Http\Requests\DomainUpdateRequest;
use PlusClouds\Core\Http\Transformers\DomainTransformer;
use PlusClouds\Core\Http\Transformers\GiftCodesTransformer;

class GiftCodesController extends AbstractController
{

    /**
     * Alan adı listesini döndürür.
     *
     * @param DomainQueryFilter $filter
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index(GiftCodesQueryFilter $filter)
    {
        $giftCodes = GiftCode::filter($filter)
            ->where('user_id', getAUUser()->id)
            ->get();

        if (!count($giftCodes)) {
            return $this->errorNotFound('Cannot find any gift code with your current search parameters. Please extend your search OR make sure that you have used a gift code for yourself.');
        }

        return $this->withCollection($giftCodes, app(GiftCodesTransformer::class));
    }

    /**
     * Alan adı bilgisini döndürür.
     *
     * @param Domain $domain
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(GiftCode $giftCode)
    {
        return $this->withItem($giftCode, app(GiftCodesTransformer::class));
    }

    public function getBycode(Request $request)
    {
        $code = $request->get('code');

        $giftCode = GiftCode::where('code', $code)->first();

        if ($giftCode) {
            return $this->withItem($giftCode, app(GiftCodesTransformer::class));
        }

        return $this->errorNotFound('Cannot find a gift code with that code');
    }
}
