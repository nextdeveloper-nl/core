<?php

namespace PlusClouds\Core\Database\Models;


use PlusClouds\Core\Database\Traits\UuidId;
use Illuminate\Database\Eloquent\SoftDeletes;
use PlusClouds\Core\Database\Traits\Filterable;

/**
 * Class Remindable
 * @package PlusClouds\Core\Database\Models
 */
class Remindable extends AbstractModel
{

    use SoftDeletes, UuidId, Filterable;

    /**
     * @var array
     */
    protected $guarded = [];


    /**
     * @var array
     */
    protected $dates = [
        'deleted_at',
        'remind_datetime',
        'snooze_datetime'
    ];

    public function contacts() {

        return $this->belongsToMany('PlusClouds\CRM\Database\Models','contact_id','remindable_id');

    }

    public function user() {
        return $this->belongsTo('PlusClouds\Account\Database\Models\User');
    }

    public function snooze($dateTime) {

        $this->snooze_datetime = $dateTime;
        $this->status = 3;
        $this->save();

    }

}