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

use Illuminate\Database\Eloquent\SoftDeletes;
use PlusClouds\Core\Database\Traits\HashId;
use PlusClouds\Core\Database\Traits\Filterable;
use PlusClouds\Core\Database\Traits\GlobalScopes\WithPassive;

/**
 * Class Domain
 * @package PlusClouds\Core\Database\Models
 */
class Domain extends AbstractModel
{

    use SoftDeletes, HashId, Filterable;
    use WithPassive;

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @var array
     */
    protected $casts = [
        'is_locked' => 'boolean',
        'is_active' => 'boolean',
    ];

    /**
     * @var array
     */
    protected $dates = [
        'deleted_at',
    ];

}