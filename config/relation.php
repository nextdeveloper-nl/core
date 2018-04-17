<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

return [
    'tag' => [
        'products' => function($self) {
            return $self->morphedByMany( 'PlusClouds\Marketplace\Database\Models\Product', 'taggable' );
        },
    ],

    'country' => [
        'products' => function($self) {
            return $self->hasMany( 'PlusClouds\Marketplace\Database\Models\Product' );
        },

        'datacenters' => function($self) {
            return $self->hasMany( 'PlusClouds\IAAS\Database\Models\Datacenter' );
        },
    ]
];