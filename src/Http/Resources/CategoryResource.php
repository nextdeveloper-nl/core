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
 * Class CategoryResource
 * @package PlusClouds\Core\Http\Resources
 */
class CategoryResource extends AbstractResource
{

    /**
     * @param \Illuminate\Http\Request $request
     *
     * @return array
     */
    public function toArray($request) {
        return $this->filterFields( [
            'id'          => $this->id_ref,
            'slug'        => $this->slug,
            'name'        => $this->name,
            'description' => $this->description,
            'is_active'   => $this->when( auth()->user(), $this->is_active ), // @todo: role kontrol edilecek
            'children'    => $this->when( ! $this->children->isEmpty(), CategoryCollection::make( $this->children ) ),
        ] );
    }

}