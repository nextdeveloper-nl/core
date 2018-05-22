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


use PlusClouds\Core\Database\Models\Category;

/**
 * Class CategoryTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class CategoryTransformer extends AbstractTransformer
{

    /**
     * @var array
     */
    protected $visible = [ 'id', 'name', 'children' ];

    /**
     * @param Category $category
     *
     * @return array
     */
    public function transform(Category $category) {
        $payload = [
            'id'          => $category->id_ref,
            'slug'        => $category->slug,
            'name'        => $category->name,
            'description' => $category->description,
            'is_active'   => $category->is_active,
        ];

        if( ! $category->children->isEmpty() ) {
            foreach( $category->children as $key => $value ) {
                $payload['children'][] = $this->transform( $value );
            }
        }

        return $this->buildPayload( $payload );
    }

}