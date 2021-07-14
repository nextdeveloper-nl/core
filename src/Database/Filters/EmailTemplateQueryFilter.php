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
 * Class CountryQueryFilter.
 *
 * @package PlusClouds\Core\Database\Filters
 */
class EmailTemplateQueryFilter extends AbstractQueryFilter {
    /**
     * @param $code
     * @param mixed $name
     *
     * @return mixed
     */
    public function name($name) {
        return $this->builder->where('name', 'like', '%'.$name.'%');
    }

    /**
     * @param mixed $locale
     *
     * @return mixed
     */
    public function locale($locale) {
        return $this->builder->where('locale', $locale);
    }
}
