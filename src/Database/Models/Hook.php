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
use PlusClouds\Core\Database\Observers\HookObserver;
use PlusClouds\Core\Database\Traits\HashId;
use PlusClouds\Core\Database\Traits\Filterable;

/**
 * @todo: Loggable trait eklenecek.
 *
 * Class Hook
 * @package PlusClouds\Core\Database\Models
 */
class Hook extends AbstractModel
{

    use SoftDeletes, HashId, Filterable;

    /**
     * @return void
     */
    public static function boot() {
        parent::boot();

        parent::observe( HookObserver::class );
    }

    /**
     * @return int
     */
    public static function position() {
        return static::max( 'position' ) + 1;
    }

}