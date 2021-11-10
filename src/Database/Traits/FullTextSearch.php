<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <recai.atak@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;

trait FullTextSearch {
    public function scopeFullTextSearch($query, $term) {
        $str = implode(',', $this->fullTextFields);
        $query->whereRaw("MATCH ({$str}) AGAINST (? IN BOOLEAN MODE)", fullTextWildcards($term));

        return $query;
    }
}
