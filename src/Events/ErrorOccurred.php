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


use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

/**
 * Class ErrorOccurred
 * @package PlusClouds\Core\Events
 */
class ErrorOccurred extends AbstractEvent
{

    use Dispatchable, SerializesModels;

    /**
     * @var string
     */
    public $title;

    /**
     * @var string
     */
    public $message;

    /**
     * @var mixed|null
     */
    public $exception;

    /**
     * ErrorOccurred constructor.
     *
     * @param $title
     * @param $message
     * @param null $exception
     */
    public function __construct($title, $message, $exception = null) {
        $this->title = $title;
        $this->message = $message;
        $this->exception = $exception;
    }

}