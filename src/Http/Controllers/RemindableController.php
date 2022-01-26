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

use PlusClouds\Account\Database\Models\User;
use PlusClouds\Core\Database\Models\Remindable;
use PlusClouds\Core\Exceptions\ObjectNotFoundException;
use PlusClouds\Core\Http\Requests\Remindable\RemindableListRequest;
use PlusClouds\Core\Http\Requests\Remindable\RemindableStoreRequest;
use PlusClouds\Core\Http\Requests\Remindable\RemindableUpdateRequest;

/**
 * Class RemindableController
 * @package PlusClouds\Core\Http\Controllers
 */
class RemindableController extends AbstractController
{
    public function index(RemindableListRequest $request)
    {
        $data = $request->validated();

        $userId = getAUUser()->id;

        $query = Remindable::where('user_id',$userId);

        if ($request->get('is_acknowledge')){
            $query->where('status',2);
        } else {
	        $query->where('status', '!=', 2);
        }

        if($request->has('remindable_object')){
            $objectArr = findObjectFromClassName($data['remindable_object'], $data['remindable_id'], 'Remindable');

            $query->where('remindable_object_type',$objectArr[0]);

            if($request->has('remindable_id')){
                $query->where('remindable_id',$objectArr[1]);
            }
        }

        $remindables = $query->get();

        return $this->withCollection($remindables, app('PlusClouds\Core\Http\Transformers\RemindableTransformer'));
    }

    public function store(RemindableStoreRequest $request)
    {
        $data = $request->validated();

		try {
			$objectArr = findObjectFromClassName($data['remindable_object'], $data['remindable_id'], 'Remindable');
		} catch (ObjectNotFoundException $e) {
			return $this->errorUnprocessable($e->getMessage());
		}

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
        $data = collect($request->validated())->forget(['is_acknowledge'])->toArray();

        if ($request->get('is_acknowledge')){
            $data['status'] = 2;
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
