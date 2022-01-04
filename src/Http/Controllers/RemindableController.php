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


use PlusClouds\Core\Database\Models\Remindable;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use PlusClouds\CRM\Database\Models\Organization;
use PlusClouds\Core\Database\Filters\RemindableQueryFilter;
use PlusClouds\Core\Http\Requests\Remindable\RemindableStoreRequest;
use PlusClouds\Core\Http\Requests\Remindable\RemindableUpdateRequest;

/**
 * Class RemindableController
 * @package PlusClouds\Core\Http\Controllers
 */
class RemindableController extends AbstractController
{

    public function index(RemindableQueryFilter $filter)
    {
        $remindables = Remindable::filter($filter)->get();


        return $this->withCollection($remindables, app('PlusClouds\Core\Http\Transformers\RemindableTransformer'));
    }

    public function store(RemindableStoreRequest $request)
    {
        $data = $request->validated();

        $objectArr = findObjectFromClassName($data['remindable_object'], $data['remindable_id'], 'Remindable');

        $remindable = Remindable::create([
            'note'                   => $data['note'] ?? null,
            'remindable_id'          => $objectArr[1],
            'remindable_object_type' => $objectArr[0],
            'remind_datetime'        => $data['remind_datetime'],
            'user_id'                => getAUUser()->id,
        ]);


        return $this->withItem($remindable, app('PlusClouds\Core\Http\Transformers\RemindableTransformer'));
    }

    public function update(RemindableUpdateRequest $request, Remindable $remindable)
    {
        $data = $request->validated();

        if ($request->has('snooze_datetime')){
            $data['status'] = 3;
        }

        $remindable->update($data);

        return $this->withItem($remindable->fresh(), app('PlusClouds\Core\Http\Transformers\RemindableTransformer'));
    }


    public function destroy(Remindable $remindable)
    {
        $remindable->delete();
        return $this->noContent();
    }
}