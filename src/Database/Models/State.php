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


/**
 * Class State
 * @package PlusClouds\Core\Database\Models
 */
class State extends AbstractModel
{

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @var string
     */
    protected $table = 'states';

    /**
     * @return MorphTo
     */
    public function model() : MorphTo {
        return $this->morphTo();
    }

    /**
     * @return string
     */
    public function __toString() : string {
        return $this->name;
    }

}