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
    public function transform($reminable)
    {
        $array = explode("\\", $reminable->remindable_object_type);

        return $this->buildPayload([
            'id'                      => $reminable->id_ref,
            'remind_datetime'         => $reminable->remind_datetime,
            'remindable_object_type'  => lowerCaseTr(end($array)),
            'remindable_object_id'    => $reminable->reminable->id_ref,
            'note'                    => $reminable->note,
            'status'                  => $reminable->status
        ]);
    }
}
