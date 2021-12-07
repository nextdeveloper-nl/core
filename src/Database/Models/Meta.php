<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Models;


use Cviebrock\EloquentSluggable\Sluggable;
use PlusClouds\Core\Database\Traits\Filterable;

/**
 * Class Meta
 * @package PlusClouds\Core\Database\Models
 */
class Meta extends AbstractModel
{

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @var array
     */
    protected $dates = [
        'deleted_at',
    ];

    protected $casts = [
        'value' => 'array',
    ];


}