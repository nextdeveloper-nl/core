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


use PlusClouds\Core\Database\Models\Tag;

/**
 * Class TagTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class TagTransformer extends AbstractTransformer
{

    /**
     * @param Tag $tag
     *
     * @return array
     */
    public function transform(Tag $tag) {
        return $this->buildPayload( [
            'slug' => $tag->slug,
            'name' => $tag->name,
        ] );
    }

}