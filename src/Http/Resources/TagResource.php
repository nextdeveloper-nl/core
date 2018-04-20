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


/**
 * Class TagResource
 * @package PlusClouds\Core\Http\Resources
 */
class TagResource extends AbstractResource
{

    /**
     * @var array
     */
    protected $withoutFields = [ 'description' ];

    /**
     * @param \Illuminate\Http\Request $request
     *
     * @return array
     */
    public function toArray($request) {
        return $this->filterFields( [
            'id'          => $this->id,
            'slug'        => $this->slug,
            'name'        => $this->name,
            'description' => $this->description,
        ] );
    }

}