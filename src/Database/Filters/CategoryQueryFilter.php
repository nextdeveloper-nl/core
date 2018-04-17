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

use PlusClouds\Core\Database\Models\Category;
use PlusClouds\Core\Database\Models\Domain;

/**
 * Class CategoryQueryFilter
 * @package PlusClouds\Core\Database\Filters
 */
class CategoryQueryFilter extends AbstractQueryFilter
{

    /**
     * Bir kategoriye ait alt kategorileri filtreler.
     *
     * @param string $categoryRef
     *
     * @return mixed
     */
    public function descendants($categoryRef) {
        $root = Category::findByRef( $categoryRef );

        return $this->builder->whereDescendantOf( $root->id );
    }

    /**
     * Bir kategoriye ait üst kategorileri filtreler.
     *
     * @param string $categoryRef
     *
     * @return mixed
     */
    public function ancestors($categoryRef) {
        $child = Category::findByRef( $categoryRef );

        return $this->builder->whereAncestorOf( $child->id );
    }

    /**
     * Alan adına göre kategorileri filtreler.
     *
     * @param string $domainRef
     *
     * @return mixed
     */
    public function domain($domainRef) {
        $domain = Domain::findByRef( $domainRef );

        return $this->builder->where( 'domain_id', $domain->id );
    }

}