<?php
/**
 * This file is part of the PlusClouds.Account library.
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
 * Class Address
 * @package PlusClouds\Core\Database\Models
 */
class Address extends AbstractModel
{
    use SoftDeletes, HashId, Filterable;

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @var array
     */
    protected $casts = [
        'is_invoice_address' => 'bool',
    ];

    /**
     * @var array
     */
    protected $dates = [
        'deleted_at',
    ];

    /**
     *
     */
    public static function boot()
    {
        parent::boot();
        parent::observe(AddressObserver::class);
    }

    /**
     * @param $value
     *
     * @return string
     */
    public function setNameAttribute($value)
    {
        return $this->attributes['name'] = ucwordsTr($value);
    }

    /**
     * @param $value
     */
    public function setLine1Attribute($value)
    {
        $this->attributes['line1'] = ucwordsTr($value);
    }

    /**
     * @param $value
     */
    public function setLine2Attribute($value)
    {
        $this->attributes['line2'] = ucwordsTr($value);
    }

    /**
     * @param $value
     */
    public function setCityAttribute($value)
    {
        $this->attributes['city'] = ucwordsTr($value);
    }

    /**
     * @param $value
     */
    public function setStateAttribute($value)
    {
        $this->attributes['state'] = ucwordsTr($value);
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphTo
     */
    public function addressable()
    {
        return $this->morphTo();
    }
}
