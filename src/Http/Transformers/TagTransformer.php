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


use League\Fractal\ParamBag;
use PlusClouds\Core\Database\Models\Tag;

/**
 * Class TagTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class TagTransformer extends AbstractTransformer
{

    /**
     * @var array
     */
    protected $visible = [ 'slug', 'name' ];

    /**
     * @var array
     */
    protected $availableIncludes = [ 'account' ];

    /**
     * @param Tag $tag
     *
     * @return array
     */
    public function transform(Tag $tag) {
        return $this->buildPayload( [
            'slug'        => $tag->slug,
            'name'        => $tag->name,
            'description' => $tag->description,
        ] );
    }

    /**
     * @param Tag $tag
     * @param ParamBag|null $paramBag
     *
     * @return \League\Fractal\Resource\Item
     */
    public function includeAccount(Tag $tag, ParamBag $paramBag = null) {
        $class = 'PlusClouds\Account\Http\Transformers\AccountTransformer';

        if( ! is_null( $tag->account ) && class_exists( $class ) ) {
            return $this->item( $tag->account, new $class( $paramBag ) );
        }
    }

}