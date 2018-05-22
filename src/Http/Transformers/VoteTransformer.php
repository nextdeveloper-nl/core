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


use PlusClouds\Core\Database\Models\Vote;

/**
 * Class VoteTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class VoteTransformer extends AbstractTransformer
{

    /**
     * @param Vote $vote
     *
     * @return array
     */
    public function transform(Vote $vote) {
        return $this->buildPayload( [
            'value'      => $vote->value,
            'created_at' => $vote->created_at->toIso8601String(),
        ] );
    }

}