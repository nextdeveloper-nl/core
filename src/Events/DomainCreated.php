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
class DomainCreated extends AbstractEvent
{

    use Dispatchable, SerializesModels;

    /**
     * @var string
     */
    public $_model;

    /**
     * ErrorOccurred constructor.
     *
     * @param $title
     * @param $message
     */
    public function __construct($model) {
		$this->_model = $model;
    }
}