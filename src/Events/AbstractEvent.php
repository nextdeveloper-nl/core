<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Events;

/**
 * Class AbstractEvent
 * @package PlusClouds\Core\Events
 */
abstract class AbstractEvent
{

    /**
     * @var int|null
     */
    protected $timestamp = null;

    /**
     * @param int $value
     *
     * @return AbstractEvent
     */
    public function setTimestamp($value) {
        $this->timestamp = $value;

        return $this;
    }

    /**
     * @return int|null
     */
    public function getTimestamp() {
        return $this->timestamp;
    }

}