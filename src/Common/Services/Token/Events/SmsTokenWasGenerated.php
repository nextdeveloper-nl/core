<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Services\Token\Events;


use Illuminate\Queue\SerializesModels;
use PlusClouds\Account\Database\Models\User;
use PlusClouds\Core\Events\AbstractEvent;

/**
 * Class SmsTokenWasGenerated
 * @package PlusClouds\Core\Common\Services\Token\Events
 */
class SmsTokenWasGenerated extends AbstractEvent
{

    use SerializesModels;

    /**
     * @var User
     */
    public $user;

    /**
     * VerificationTokenWasGenerated constructor.
     *
     * @param User $user
     */
    public function __construct(User $user) {
        $this->user = $user;
    }

}