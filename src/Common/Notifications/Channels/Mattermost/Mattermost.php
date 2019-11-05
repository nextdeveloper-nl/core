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


use GuzzleHttp\Client;

/**
 * Class Mattermost
 * @package PlusClouds\Core\Common\Notifications\Channels\Mattermost
 */
class Mattermost
{

    /**
     * Guzzle HTTP Client
     *
     * @var Client
     */
    public $mattermost;

    /**
     * Default webhook URL
     *
     * @var string
     */
    public $webhook;

    /**
     * Mattermost constructor.
     *
     * @param Client $mattermost
     * @param null $webhook
     */
    public function __construct(Client $mattermost, $webhook = null) {
        $this->mattermost = $mattermost;
        $this->webhook = $webhook;
    }

    /**
     * @param Message $message
     * @param null $webhook
     */
    public function send(Message $message, $webhook = null) {
        if( is_null( $webhook ) and is_null( $this->webhook ) ) {
            throw new MattermostException(
                "No default webhook configured. Please put a webhook URL as a second parameter of the constructor or of the `send` function."
            );
        }
        if( is_null( $webhook ) ) {
            $webhook = $this->webhook;
        }
        $this->mattermost->post( $webhook, [
            'json' => $message->toArray(),
        ], [
            'Content-Type' => 'application/json',
        ] );
    }

}