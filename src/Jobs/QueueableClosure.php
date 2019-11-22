<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Jobs;


use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Opis\Closure\SerializableClosure;

/**
 * Class QueueableClosure
 * @package PlusClouds\Core\Jobs
 */
class QueueableClosure extends SerializableClosure implements ShouldQueue
{

    use Dispatchable, Queueable, InteractsWithQueue;
    use Watchable;

    /**
     * @return void
     */
    public function handle() {
        call_user_func_array( $this->getClosure(), func_get_args() );
    }

}