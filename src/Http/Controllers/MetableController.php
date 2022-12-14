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

use PlusClouds\Core\Database\Models\Meta;
use PlusClouds\Core\Http\Requests\Meta\MetaListRequest;
use PlusClouds\Core\Http\Requests\Meta\MetaStoreRequest;
use PlusClouds\Core\Http\Requests\Meta\MetaUpdateRequest;

/**
 * Class DiscountableController.
 *
 * @package PlusClouds\Core\Http\Controllers
 */
class MetableController extends AbstractController
{

	/**
	 *
	 * @param MetaListRequest $request
	 * @return \Illuminate\Http\JsonResponse
	 * @throws \PlusClouds\Core\Exceptions\ObjectNotFoundException
	 */
    public function index(MetaListRequest $request)
    {
        $data = $request->validated();

        $objectArr = findObjectFromClassName($data['object'], $data['object_id'], 'Meta');

        $metas = Meta::where([['metable_type',$objectArr[0]],['metable_id',$objectArr[1]]])->get();

        return $this->withCollection($metas, app('PlusClouds\Core\Http\Transformers\MetaTransformer'));
    }

	/**
	 * @param MetaStoreRequest $request
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 * @throws \PlusClouds\Core\Exceptions\ObjectNotFoundException
	 */
    public function store(MetaStoreRequest $request)
    {
        $data = $request->validated();

        $objectArr = findObjectFromClassName($data['object'], $data['object_id'], 'Meta');

        Meta::create([
            'value' => $data['value'],
            'key' => $data['key'],
            'metable_type' => $objectArr[0],
            'metable_id' => $objectArr[1]
        ]);

        return $this->noContent();
    }

	/**
	 * @param MetaUpdateRequest $request
	 * @param Meta $meta
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 */
    public function update(MetaUpdateRequest $request, Meta $meta)
    {
        $meta->value = $request->validated()['value'];
        $meta->save();

        return $this->noContent();
    }

	/**
	 * @param Meta $meta
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 */
    public function destroy(Meta $meta)
    {
        $meta->destroy();

        return $this->noContent();
    }
}
