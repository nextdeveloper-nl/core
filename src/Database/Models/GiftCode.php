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
use PlusClouds\Core\Database\Traits\Filterable;
use PlusClouds\Core\Database\Traits\UuidId;

/**
 * Class Discount.
 *
 * @package PlusClouds\Core\Database\Models
 */
class GiftCode extends AbstractModel {
    use SoftDeletes, UuidId, Filterable;

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
    protected $guarded = [];

    /**
     * @var array
     */
    protected $casts = [
        'discount_type'   => 'bool',
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
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function account() {
        return $this->belongsTo('PlusClouds\Account\Database\Models\Account');
    }

	/*
	 * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
	 */
	public function user() {
		return $this->belongsTo('PlusClouds\Account\Database\Models\User');
	}
}
