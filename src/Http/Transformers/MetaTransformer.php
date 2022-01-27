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

use PlusClouds\Core\Database\Models\Meta;

/**
 * Class VoteTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class MetaTransformer extends AbstractTransformer
{

    /**
     * @param Vote $vote
     *
     * @return array
     */
    public function transform($reminable)
    {
        return $this->buildPayload([
            'id'        => $reminable->id,
            'key'       => $reminable->key,
            'value'     => $reminable->value,
        ]);
    }
}
