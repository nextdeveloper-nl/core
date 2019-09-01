<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\Events;


use Illuminate\Http\Request;

/**
 * Class CacheMissed
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Events
 */
class CacheMissed
{

    /** @var \Illuminate\Http\Request */
    public $request;

    /**
     * CacheMissed constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request) {
        $this->request = $request;
    }

}