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
 * Class HookLog
 * @package PlusClouds\Core\Database\Models
 */
class HookLog extends AbstractModel
{

    /**
     * @var array
     */
    protected $casts = [
        'payload' => 'array',
    ];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphTo
     */
    public function loggable() {
        return $this->morphTo();
    }

}