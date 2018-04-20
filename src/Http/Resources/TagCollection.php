<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Resources;


use Illuminate\Http\Resources\Json\ResourceCollection;
use PlusClouds\Core\Common\Contracts\IResource;

/**
 * Class TagCollection
 * @package PlusClouds\Core\Http\Resources
 */
class TagCollection extends ResourceCollection implements IResource
{

    /**
     * @param \Illuminate\Http\Request $request
     *
     * @return array
     */
    public function toArray($request) {
        return $this->collection->map( function($tag) {
            return new TagResource( $tag );
        } )->toArray();
    }

}