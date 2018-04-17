<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;

use PlusClouds\Core\Database\Models\Vote;

/**
 * Trait Voteable
 * @package PlusClouds\Core\Database\Traits
 */
trait Voteable
{

    /**
     * @return mixed
     */
    public function votes() {
        return $this->morphMany( Vote::class, 'voteable' );
    }

}