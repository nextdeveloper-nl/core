<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Controllers;

use PlusClouds\Core\Broadcasts\TestBroadcast;

class TestBroadcastController extends AbstractController {
    /**
     * @return void
     */
    public function test() {
        broadcast(new TestBroadcast());

        return $this->withItem(['result' => true], function ($item) {
            return $item;
        });
    }
}
