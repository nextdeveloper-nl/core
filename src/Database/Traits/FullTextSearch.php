<?php

namespace PlusClouds\CRM\Helpers\Traits;

trait FullTextSearch
{

    public function scopeFullTextSearch($query, $term,array $colums)
    {
        $str = implode(',',$colums);
        $query->whereRaw("MATCH ($str) AGAINST (? IN BOOLEAN MODE)" , fullTextWildcards($term));
        return $query;
    }

}