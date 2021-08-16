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

use Cviebrock\EloquentSluggable\Services\SlugService;
use Cviebrock\EloquentSluggable\Sluggable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use PlusClouds\Core\Database\Traits\GlobalScopes\WithPassive;
use PlusClouds\Core\Database\Traits\HashId;
use PlusClouds\Core\Database\Traits\Filterable;
use Kalnoy\Nestedset\NodeTrait;

/**
 * Class Category
 * @package PlusClouds\Core\Database\Models
 */
class Category extends AbstractModel
{
    use HashId, Filterable, WithPassive;
    use NodeTrait, Sluggable {
        Sluggable::replicate insteadof NodeTrait;
    }

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @var array
     */
    protected $casts = [
        'is_active' => 'bool',
    ];

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
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function domain() {
        return $this->belongsTo( Domain::class, 'domain_id' );
    }

}