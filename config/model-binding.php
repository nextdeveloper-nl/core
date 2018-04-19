<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use PlusClouds\Core\Database\Models\Country;
use PlusClouds\Core\Database\Models\Category;
use PlusClouds\Core\Database\Models\Domain;

return [
    'country' => function($value) {
        if( ! ( $category = Country::where( 'code', strtoupper( $value ) )->first() ) ) {
            throw new \Illuminate\Database\Eloquent\ModelNotFoundException( 'Could not find the records you are looking for.' );
        }

        return $category;
    },

    'category' => function($value) {
        return Category::findByRef( $value );
    },

    'domain' => function($value) {
        return Domain::findByRef( $value );
    },
];