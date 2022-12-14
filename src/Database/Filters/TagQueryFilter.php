<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Filters;


/**
 * Class TagQueryFilter
 * @package PlusClouds\Core\Database\Filters
 */
class TagQueryFilter extends AbstractQueryFilter
{

    /**
     * @param $type
     *
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function type($type) {
        return $this->builder->where( 'type', $type );
    }

    public function name($name) {
        return $this->builder->where('name', $name );
    }
}