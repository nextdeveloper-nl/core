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
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Queue;

/**
 * Class AbstractJob
 * @package PlusClouds\Core\Jobs
 */
class AbstractJob
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    use Watchable;

    public function failed(\Exception $exception)
    {
        switch ($exception->getMessage()) {
            //  This is a possible bugfix for redis queue problems
            case "fclose(): supplied resource is not a valid stream resource":
                logger()->error('[AbstractJob|Failed] Redis probably is dead and job tries to retry again. So we are basicly logging this and failing the job.');
                return;
        }

        switch ($exception->getCode()) {
            case 0:
                throw $exception;
        }
    }

    public function checkQueue($maxQueueItem = 100)
    {
        $queue = $this->queue;

        if (is_null($queue)) {
            $queue = 'general';
        }

        $queueSize = Queue::size($this->queue);

        if ($queueSize) {
            if ($queueSize > $maxQueueItem) {
                logger()->info('[Queue: ' . $queue . '] Too many jobs (' . $queueSize . ') are in the queue, quiting.');
                $this->markAsJobCompleted();
            } else {
                $maxQueueItem -= $queueSize;

                logger()->info('[Queue: ' . $queue . '] Max scan size is reduced to: ' . $maxQueueItem);
            }
        }

        return $maxQueueItem;
    }
}
