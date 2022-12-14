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

use Illuminate\Database\Eloquent\Relations\MorphTo;
use Illuminate\Database\Eloquent\SoftDeletes;
use PlusClouds\Core\Database\Traits\Filterable;
use PlusClouds\Core\Database\Traits\UuidId;

/**
 * Class State
 * @package PlusClouds\Core\Database\Models
 */
class ServiceRole extends AbstractModel
{
    use SoftDeletes,UuidId , Filterable;

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @var array
     */
    protected $casts = [
        'has_update' => 'bool',
    ];
    /**
     * @var string
     */
    protected $table = 'service_roles';

    /**
     * @return MorphTo
     */
    public function model() : MorphTo
    {
        return $this->morphTo();
    }

    /**
     * @return string
     */
    public function __toString() : string
    {
        return $this->name;
    }
}
