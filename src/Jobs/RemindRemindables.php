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


use Illuminate\Contracts\Queue\ShouldQueue;
use PlusClouds\Core\Database\Models\Remindable;
use Carbon\Carbon;

/**
 * Class RemindRemindables
 * @package PlusClouds\Core\Jobs
 */
class RemindRemindables extends AbstractJob implements ShouldQueue
{


    public function handle()
    {

        $waitingAlarm = Remindable::where('status', 0)->whereDate('snooze_datetime', '<', Carbon::now())->get()->toArray();

        //bunları ayrı ayrı çektik ilerde snoozed ile ilgili başka birşey yapılmak istenebilir.
        $snoozedAlarm = Remindable::where('status', 3)->whereDate('snooze_datetime', '<', Carbon::now())->get()->toArray();

        $alarms = array_merge($waitingAlarm, $snoozedAlarm);

        foreach ($alarms as $alarm) {

            $alarm->user->say(new MailVerificationNotification('Alarm Çalıyor ! '. $alarm->note));

            //gönderimden sonra çalıyor statüsüne alıyoruz
            $alarm->status = 1;
            $alarm->save();

        }

    }

}