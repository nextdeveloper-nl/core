<?php
/**
 * This file is part of the PlusClouds-5.5 library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Notifications;


use Illuminate\Notifications\Notification;
use NotificationChannels\Twilio\TwilioChannel;

/**
 * Class AbstractNotification
 * @package PlusClouds\Core\Notifications
 */
class AbstractNotification extends Notification
{

    /**
     * @var array
     */
    protected $channels = [ 'database', 'mail' ];

    /**
     * @param $notifiable
     *
     * @return array
     */
    public function via($notifiable) {
        if( $notifiable->hasMeta( 'notification_settings.slack' ) ) {
            if( (bool) $notifiable->getMeta( 'notification_settings.slack.is_active' ) == true ) {
                array_push( $this->channels, 'slack' );
            }
        }

        if( $notifiable->hasMeta( 'notification_settings.sms' ) ) {
            if( (bool) $notifiable->getMeta( 'notification_settings.sms.is_active' ) == true ) {
                array_push( $this->channels, TwilioChannel::class );
            }
        }

        return $this->channels;
    }

}