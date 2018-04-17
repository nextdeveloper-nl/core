<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;

use PlusClouds\Core\Database\Filters\AbstractQueryFilter;

/**
 * Trait Filterable
 * @package PlusClouds\Core\Database\Traits
 */
trait Filterable
{

    /**
     * Filter a result set
     *
     * @param $query
     * @param AbstractQueryFilter $filter
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeFilter($query, AbstractQueryFilter $filter) {
        return $filter->apply( $query );
    }

}