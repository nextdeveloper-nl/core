<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Events;


use Illuminate\Database\Eloquent\Model;
use PlusClouds\Core\Database\Models\State;

/**
 * Class StateUpdated
 * @package PlusClouds\Core\Events
 */
class StateUpdated
{

    /**
     * @var \PlusClouds\Core\Database\Models\State|null
     */
    public $oldState;

    /**
     * @var \PlusClouds\Core\Database\Models\State
     */
    public $newState;

    /**
     * @var \Illuminate\Database\Eloquent\Model
     */
    public $model;

    /**
     * StateUpdated constructor.
     *
     * @param State|null $oldState
     * @param State $newState
     * @param Model $model
     */
    public function __construct(State $oldState = null, State $newState, Model $model) {
        $this->oldState = $oldState;
        $this->newState = $newState;
        $this->model = $model;
    }

}