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


use PlusClouds\Core\Database\Models\Remindable;

/**
 * Class VoteTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class RemindableTransformer extends AbstractTransformer
{

    /**
     * @param Vote $vote
     *
     * @return array
     */
    public function transform($reminable) {
        return $this->buildPayload( [
            'remind_datetime'         => $reminable->remind_datetime,
            'object_id'               => $reminable->remindable_id,
            'remindable_object_type'  => $reminable->remindable_object,
            'snooze_datetime'         => $reminable->snooze_datetime,
            'note'                    => $reminable->note,
        ] );
    }

}