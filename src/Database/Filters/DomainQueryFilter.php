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
 * Class DomainQueryFilter
 * @package PlusClouds\Core\Database\Filters
 */
class DomainQueryFilter extends AbstractQueryFilter
{

    /**
     * @return mixed
     */
    public function locked() {
        return $this->builder->where( 'is_locked', true );
    }

    /**
     * @return mixed
     */
    public function passive() {
        return $this->builder->withPassive();
    }

    /**
     * Filters domains with domain name
     *
     * @param $name
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function name( $name ) {
        return $this->builder->where('name', '%' . $name . '%');
    }
}