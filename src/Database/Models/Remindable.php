<?php

namespace PlusClouds\Core\Database\Models;


use Illuminate\Database\Eloquent\SoftDeletes;
use PlusClouds\Core\Database\Traits\Filterable;
use PlusClouds\Core\Database\Traits\HashId;

/**
 * Class Remindable
 * @package PlusClouds\Core\Database\Models
 */
class Remindable extends AbstractModel
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
        'remind_datetime',
        'snooze_datetime'
    ];

    public function contacts() {

        return $this->belongsToMany('PlusClouds\CRM\Database\Models','contact_id','remindable_id');

    }

}