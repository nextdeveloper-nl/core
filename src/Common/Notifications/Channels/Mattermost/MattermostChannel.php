<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Notifications\Channels\Mattermost;


use Illuminate\Notifications\Notification;

/**
 * Class MattermostChannel
 * @package PlusClouds\Core\Common\Notifications\Channels\Mattermost
 */
class MattermostChannel
{

    /**
     * The Mattermost HTTP instance.
     *
     * @var Mattermost
     */
    protected $mattermost;

    /**
     * Create a new Mattermost channel instance.
     *
     * @param Mattermost $mattermost
     *
     * @return void
     */
    public function __construct(Mattermost $mattermost) {
        $this->mattermost = $mattermost;
    }

    /**
     * Send the given notification.
     *
     * @param mixed $notifiable
     * @param \Illuminate\Notifications\Notification $notification
     *
     * @return \Psr\Http\Message\ResponseInterface
     */
    public function send($notifiable, Notification $notification) {
        if( ! $url = $notifiable->routeNotificationFor( 'mattermost' ) ) {
            return;
        }

        $message = $notification->toMattermost( $notifiable );

        return $this->mattermost->send( $message, $url );
    }


}