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
    'user' => [
        'country' => function($self) {
            return $self->belongsTo( 'PlusClouds\Core\Database\Models\Country', 'country_id' );
        },
    ],

    'address' => [
        'country' => function($self) {
            return $self->belongsTo( 'PlusClouds\Core\Database\Models\Country', 'country_id' );
        },
    ],

    'country' => [

        'datacenters' => function($self) {
            return $self->hasMany( 'PlusClouds\IAAS\Database\Models\Datacenter' );
        },
    ],
];