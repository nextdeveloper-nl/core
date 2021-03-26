<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Transformers;

use PlusClouds\Core\Database\Models\State;

/**
 * Class AttachmentTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class StateTransformer extends AbstractTransformer
{

    /**
     * @var array
     */
    protected $visible = [ 'name', 'value', 'reason', 'created_at', 'updated_at' ];

    /**
     * @param State $state
     *
     * @return array
     */
    public function transform(State $state) {
        return $this->buildPayload( [
            'name'          => $state->name,
            'value'         => $state->value,
            'reason'        => $state->reason,
            'created_at'    => $state->created_at->toIso8601String(),
            'updated_at'      => $this->when( ! is_null( $state->updated_at ), optional( $state->updated_at )->toIso8601String() ),
        ] );
    }

}