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

/**
 * Class Discount
 * @package PlusClouds\Core\Database\Models
 */
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
        'custom_start_at',
        'custom_expires_at',
    ];

    /**
     * @return void
     */
    public static function boot() {
        parent::boot();

        parent::observe( DiscountObserver::class );
    }

    /**
     * @return null|Carbon
     */
    public function getStartAtAttribute() {
        $startAt = optional( $this->pivot )->custom_start_at ?? $this->attributes['start_at'];

        return ! is_null( $startAt ) ? Carbon::parse( $startAt ) : null;
    }

    /**
     * @return null|Carbon
     */
    public function getExpiresAtAttribute() {
        $expiresAt = optional( $this->pivot )->custom_expires_at ?? $this->attributes['expires_at'];

        return ! is_null( $expiresAt ) ? Carbon::parse( $expiresAt ) : null;
    }

}