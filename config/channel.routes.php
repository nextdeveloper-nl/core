<?php
/**
 * This file is part of the PlusClouds.IAAS library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use Illuminate\Support\Facades\Broadcast;
use PlusClouds\Account\Database\Models\Account;

Broadcast::channel('broadcast.test', function ($authUser, Account $account) {
    return hasAccount($authUser, $account) || isTeammate($authUser, $account);
});
