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


use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Queue\SerializesModels;

/**
 * Class JobUpdated
 * @package PlusClouds\Core\Events
 */
class JobUpdated extends AbstractEvent
{

    use InteractsWithSockets, SerializesModels;
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

    /**
     * @return string
     */
    public function broadcastAs() {
        return 'watchable.job';
    }

    /**
     * @return PrivateChannel
     */
    public function broadcastOn() {
        return new PrivateChannel( 'watchable.job.'.$this->watchableData['id'] );
    }

}