<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Broadcasts;

use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;

/**
 * @internal
 */
class TestBroadcast extends AbstractBroadcast implements ShouldBroadcastNow {
    /**
     * @return \Illuminate\Broadcasting\Channel|\Illuminate\Broadcasting\Channel[]|PrivateChannel
     */
    public function broadcastOn() {
        return new PrivateChannel('broadcast.test');
    }

    /**
     * @return string
     */
    public function broadcastAs() {
        return 'broadcast-test';
    }

    /**
     * @return array
     */
    public function broadcastWith() {
        return [
            'message' => 'You must be shapeless, formless, like water. When you pour water in a cup, it becomes the cup. When you pour water in a bottle, it becomes the bottle. When you pour water in a teapot, it becomes the teapot. Water can drip and it can crash. Become like water my friend. by Bruce Lee',
        ];
    }
}
