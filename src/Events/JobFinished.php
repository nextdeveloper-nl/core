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


use Illuminate\Queue\SerializesModels;

/**
 * Class JobFinished
 * @package PlusClouds\Core\Events
 */
class JobFinished extends AbstractEvent
{

    use SerializesModels;
    /**
     * @var array
     */
    public $watchableData;

    /**
     * Create a new event instance.
     *
     * @param array $watchableData
     */
    public function __construct(array $watchableData) {
        $this->watchableData = $watchableData;
    }

}