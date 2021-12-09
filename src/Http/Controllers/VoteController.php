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
use PlusClouds\Core\Database\Models\Meta;
use PlusClouds\Core\Http\Requests\Vote\VoteStoreRequest;
use PlusClouds\Core\Http\Requests\Vote\VoteUpdateRequest;

/**
 * Class StateController
 * @package PlusClouds\Core\Http\Controllers
 */
class VoteController extends AbstractController
{

    public function store(VoteStoreRequest $request)
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

    public function update(VoteUpdateRequest $request, Meta $meta)
    {

        $meta->value = $request->validated()['value'];
        $meta->save();

        return $this->noContent();
    }


    public function destroy(Meta $meta)
    {

        $meta->destroy();

        return $this->noContent();
    }


}