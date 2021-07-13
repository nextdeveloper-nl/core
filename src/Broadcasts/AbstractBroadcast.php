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

use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Queue\SerializesModels;

/**
 * Class AbstractBroadcast.
 *
 * @package PlusClouds\Core\Broadcasts
 */
abstract class AbstractBroadcast implements IBroadcast {
    use InteractsWithSockets, SerializesModels;

    /**
     * @var null|string
     */
    public $eventLogObject = 'NonObject';

    /**
     * @var null|string
     */
    public $eventLogMessage = 'NonMessage';
}
