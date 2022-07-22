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

use PlusClouds\Core\Database\Models\State;
use PlusClouds\Core\Http\Requests\State\StateStoreRequest;
use PlusClouds\Core\Http\Requests\State\StateUpdateRequest;
use PlusClouds\Core\Http\Requests\State\VoteStoreController;

/**
 * Class StateController
 * @package PlusClouds\Core\Http\Controllers
 */
class StateController extends AbstractController
{
	/**
	 * @name Create a new State
	 *
	 * @param StateStoreRequest $request
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 * @throws \PlusClouds\Core\Exceptions\ObjectNotFoundException
	 */
    public function store(StateStoreRequest $request)
    {
        $data = $request->validated();

        $classArr = findObjectFromClassName($data['object'], $data['object_id'], 'HasStates');

        if (empty($classArr)) {
            logger()->error('[State|Store] Object Not Found');

            throw new \Exception('Object Not Found');
        }

        State::create([
            'model_type' => $classArr[0],
            'model_id'   => $classArr[1],
            'name'       => $data['state_name'],
            'value'      => $data['state_value'],
            'reason'     => $data['state_reason'] ?? '',
        ]);

        return $this->noContent();
    }

	/**
	 * @name Updates State
	 *
	 * @param StateUpdateRequest $request
	 * @param State $state
	 * @return \Illuminate\Contracts\Routing\Respactory|\SymonseFfony\Component\HttpFoundation\Response
	 */
    public function update(StateUpdateRequest $request, State $state)
    {
        $data = $request->validated();

        $state->update([
            'name'       => $data['state_name'],
            'value'      => $data['state_value'],
            'reason'     => $data['state_reason'] ?? '',
        ]);

        return $this->noContent();
    }

	/**
	 * @name Delete a State
	 *
	 * @param State $state
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 */
    public function destroy(State $state)
    {
        $state->destroy();

        return $this->noContent();
    }
}
