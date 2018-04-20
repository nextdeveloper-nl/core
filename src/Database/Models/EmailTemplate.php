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
use PlusClouds\Core\Database\Traits\Filterable;
use PlusClouds\Core\Database\Traits\HashId;

/**
 * Class EmailTemplate
 * @package PlusClouds\Core\Database\Models
 */
class EmailTemplate extends AbstractModel
{

    use SoftDeletes, HashId, Filterable;

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
     * @param $query
     * @param $name
     * @param null $locale
     *
     * @return mixed
     */
    public function scopeByName($query, $name, $locale = null) {
        return $query->where( 'name', $name )
            ->where( 'locale', ( $locale ?? app()->getLocale() ) );
    }

}