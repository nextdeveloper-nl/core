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
use Illuminate\Support\Carbon;
use PlusClouds\Core\Database\Observers\DiscountObserver;
use PlusClouds\Core\Database\Traits\HashId;

class Discount extends AbstractModel
{

    use SoftDeletes, HashId;

    /**
     * @var array
     */
    public static $type = [
        'percent' => 0,
        'price'   => 1,
    ];

    /**
     * @var array
     */
    protected $fillable = [
        'title',
        'discount_type',
        'percentage',
        'price',
        'currency_code',
        'min_order_value',
        'start_at',
        'expires_at',
    ];

    /**
     * @var array
     */
    protected $casts = [
        'percentage'      => 'double',
        'price'           => 'double',
        'min_order_value' => 'double',
    ];

    /**
     * @var array
     */
    protected $dates = [
        'start_at',
        'expires_at',
        'deleted_at',
    ];

    public static function boot() {
        parent::boot();

        parent::observe( DiscountObserver::class );
    }

    /**
     * @return null|Carbon
     */
    public function getStartAtAttribute() {
        return $this->attributes['start_at'] ??
            $this->pivot->custom_start_at ? Carbon::parse( $this->pivot->custom_start_at ) : null;
    }

    /**
     * @return null|Carbon
     */
    public function getExpiresAtAttribute() {
        return $this->attributes['expires_at'] ??
            $this->pivot->custom_expires_at ? Carbon::parse( $this->pivot->custom_expires_at ) : null;
    }

}