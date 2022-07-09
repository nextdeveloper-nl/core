<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use PlusClouds\Core\Database\Models\Comment;
use PlusClouds\Core\Database\Models\Country;
use PlusClouds\Core\Database\Models\Category;
use PlusClouds\Core\Database\Models\Discount;
use PlusClouds\Core\Database\Models\Domain;
use PlusClouds\Core\Database\Models\EmailTemplate;
use PlusClouds\Core\Database\Models\Hook;
use PlusClouds\Core\Database\Models\Tag;

return [
    'country' => function($value) {
        if( ! ( $category = Country::where( 'code', strtoupper( $value ) )->first() ) ) {
            throw new \Illuminate\Database\Eloquent\ModelNotFoundException( 'Could not find the country from its code.' );
        }

        return $category;
    },

    'category' => function($value) {
        return Category::findByRef( $value );
    },

    'domain' => function($value) {
        return Domain::findByRef( $value );
    },

    'discount' => function($value) {
        return Discount::findByRef( $value );
    },

    'template' => function($value) {
        return EmailTemplate::findByRef( $value );
    },

    'hook' => function($value) {
        return Hook::findByRef( $value );
    },

    'tag' => function($value) {
        return Tag::where( 'slug', $value )->firstOrFail();
    },

    'comment' => function($value) {
        return Comment::findByRef( $value );
    },

    'address' => function($value) {
        return \PlusClouds\Core\Database\Models\Address::findByRef( $value );
    },

    'remindable'    =>  function($value) {
        return \PlusClouds\Core\Database\Models\Remindable::findByRef($value);
    },

    'serviceRole'    =>  function($value) {
        return \PlusClouds\Core\Database\Models\ServiceRole::findByRef($value);
    }
];