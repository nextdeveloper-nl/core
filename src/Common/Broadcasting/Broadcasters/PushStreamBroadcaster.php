<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Broadcasting\Broadcasters;


use Illuminate\Support\Str;
use Illuminate\Broadcasting\Broadcasters\Broadcaster;
use GuzzleHttp\Client;
use Symfony\Component\HttpKernel\Exception\HttpException;

/**
 * Class PushStreamBroadcaster
 * @package PlusClouds\Core\Common\Broadcasting\Broadcasters
 */
class PushStreamBroadcaster extends Broadcaster
{

    /**
     * @var Client
     */
    private $client;

    /**
     * PushStreamBroadcaster constructor.
     *
     * @param Client $client
     */
    public function __construct(Client $client) {
        $this->client = $client;
    }

    /**
     * @param array $channels
     * @param string $event
     * @param array $payload
     *
     * @throws \GuzzleHttp\Exception\GuzzleException
     */
    public function broadcast(array $channels, $event, array $payload = array()) {
        foreach( $channels as $channel ) {
            $payload = array_merge( [ 'eventtype' => $event ], $payload );

            $response = $this->client->request( 'POST', '/pub?id='.$channel, [ 'json' => $payload ] );
        }
    }

    /**
     * @param \Illuminate\Http\Request $request
     *
     * @return mixed
     */
    public function auth($request) {
        if( Str::startsWith( $request->channel_name, [ 'private-', 'presence-' ] ) &&
            ! $request->user() ) {
            throw new HttpException( 403 );
        }

        $channelName = Str::startsWith( $request->channel_name, 'private-' )
            ? Str::replaceFirst( 'private-', '', $request->channel_name )
            : Str::replaceFirst( 'presence-', '', $request->channel_name );

        return parent::verifyUserCanAccessChannel(
            $request, $channelName
        );
    }

    /**
     * @param \Illuminate\Http\Request $request
     * @param mixed $result
     *
     * @return bool|mixed
     */
    public function validAuthenticationResponse($request, $result) {
        return true;
    }

}