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


use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Queue\Events\JobFailed;
use PlusClouds\Core\Common\Notifications\Channels\Mattermost\Attachment;
use PlusClouds\Core\Common\Notifications\Channels\Mattermost\MattermostChannel;
use PlusClouds\Core\Common\Notifications\Channels\Mattermost\Message;

/**
 * Class QueueFailed
 * @package PlusClouds\Core\Notifications
 */
class QueueFailed extends Notification
{

    use Queueable;

    /**
     * @var JobFailed
     */
    public $event;

    /**
     * QueueFailed constructor.
     *
     * @param JobFailed $event
     */
    public function __construct(JobFailed $event) {
        $this->event = $event;
    }

    /**
     * @param $notifiable
     *
     * @return array
     */
    public function via($notifiable) {
        return [ MattermostChannel::class ];
    }

    /**
     * @param $notifiable
     *
     * @return Message
     */
    public function toMattermost($notifiable) {
        return ( new Message )
            ->text( sprintf( "%s isimli job tamamlanamad─▒.", $this->event->job->resolveName() ) )
            ->channel( 'Bugs' )
            ->username( 'heisenberg' )
            ->attachment( function(Attachment $attachment) {
                $attachment->field( 'Job', $this->event->job->resolveName(), true );
                $attachment->field( 'Payload', $this->event->job->getRawBody(), false );
                $attachment->field( 'Exception', $this->event->exception->getTraceAsString(), false );
            } );
    }

}