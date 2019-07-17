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
 * Class Tag
 * @package PlusClouds\Core\Database\Models
 */
class Tag extends AbstractModel
{

    use Sluggable, Filterable;

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

    /**
     * @return array
     */
    public function sluggable() {
        return [
            'slug' => [
                'source' => 'name',
            ],
        ];
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo|null
     */
    public function account() {
        $class = 'PlusClouds\Account\Database\Models\Account';

        if( class_exists( $class ) ) {
            return $this->belongsTo( $class, 'account_id' );
        }

        return null;
    }

}