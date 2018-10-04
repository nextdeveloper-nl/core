<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;

use GuzzleHttp\Client;
use GuzzleHttp\Promise;
use GuzzleHttp\Exception\RequestException;
use Psr\Http\Message\ResponseInterface;
use PlusClouds\Core\Database\Models\Hook;
use PlusClouds\Core\Database\Models\HookLog;
use PlusClouds\Core\Common\Enums\HookMethod;

/**
 * Trait Hookable
 * @package PlusClouds\Core\Database\Traits
 */
trait Hookable
{

    /**
     * @return mixed
     */
    public function hooks() {
        return $this->morphToMany( Hook::class, 'hookable' )
            ->orderBy( 'hooks.position', 'ASC' )
            ->withTimestamps();
    }

    /**
     * @return mixed
     */
    public function hookLogs() {
        return $this->morphMany( HookLog::class, 'loggable' );
    }

    /**
     * @param array $data
     *
     * @return mixed
     */
    public function createHook($data) {
        $hook = Hook::firstOrCreate( $data );

        if( ! $this->hooks->contains( $hook->getKey() ) ) {
            $this->hooks()->attach( $hook->getKey() );
        }

        return $hook;
    }

    /**
     * @param int|array|Hook $hooks
     *
     * @return mixed
     */
    public function addHook($hooks) {
        if( ! is_array( $hooks ) ) {
            $hooks = [ $hooks ];
        }

        foreach( $hooks as $hook ) {
            if( ! $hook instanceof Hook ) {
                $hook = Hook::find( $hook );
            }

            if( $hook && ! $this->hooks->contains( $hook->getKey() ) ) {
                $this->hooks()->attach( $hook->getKey() );
            }

        }

        return $this->load( 'hooks' );
    }

    /**
     * @param int|array|Hook $hooks
     *
     * @return mixed
     */
    public function updateHook($hooks) {
        if( ! is_array( $hooks ) ) {
            $hooks = [ $hooks ];
        }

        foreach( $hooks as $hook ) {
            if( ! $hook instanceof Hook ) {
                $hook = Hook::find( $hook );
            }

            if( $hook && ! $this->hooks->contains( $hook->getKey() ) ) {
                $this->hooks()->detach( $hook->getKey() );
            }
        }

        return $this->load( 'hooks' );
    }

    /**
     * @param int|array|Hook $hooks
     *
     * @return mixed
     */
    public function deleteHook($hooks) {
        if( ! is_array( $hooks ) ) {
            $hooks = [ $hooks ];
        }

        foreach( $hooks as $hook ) {
            if( ! $hook instanceof Hook ) {
                $hook = Hook::find( $hook );
            }

            if( $hook && $this->hooks->contains( $hook->getKey() ) ) {
                $this->hooks()->detach( $hook->getKey() );
            }
        }

        return $this->load( 'hooks' );
    }

    /**
     * @return mixed
     */
    public function removeAllHooks() {
        $this->hooks()->sync( [] );

        return $this->load( 'hooks' );
    }

    /**
     * @param Hook $hook
     * @param $data
     *
     * @return mixed
     */
    public function createHookLog(Hook $hook, $data) {
        $log = new HookLog();
        $log->forceFill( array_merge( $data, [
            'hook_id' => $hook->id,
        ] ) );

        $this->hookLogs()->save( $log );

        return $log->fresh();
    }

    /**
     * @param string $action
     * @param string $behavior
     *
     * @return array|mixed
     */
    public function executeHooks($action, $behavior) {
        $results = [];

        $hooks = $this->hooks()->where( 'hooks.action', $action )
            ->where( 'hooks.behavior', $behavior )
            ->orderBy( 'position', 'ASC' )
            ->orderBy( 'id', 'ASC' )
            ->get();

        if( $hooks->isNotEmpty() ) {
            $promises = [];

            $logger = function($loggable, $response) {
                if( ( $contentType = $response->getHeader( 'Content-Type' )[0] ) == 'application/json' ) {
                    $body = json_encode( json_decode( $response->getBody()->getContents(), true ) );
                } else {
                    $body = $response->getBody()->getContents();
                }

                $loggable->response_content_type = $contentType;
                $loggable->response_code = $response->getStatusCode();
                $loggable->response = $body;
                $loggable->save();
            };

            $client = app( Client::class );

            $hooks->each( function($hook, $key) use (&$client, &$promises, &$logger) {
                if( $hook->method == HookMethod::GET ) {
                    $parameters = [
                        'query' => $hook->parameters,
                    ];
                } else {
                    $parameters = [
                        'form_params' => $hook->parameters,
                    ];
                }

                $log = $this->createHookLog( $hook, [
                    'payload' => $parameters,
                ] );

                $promises[ $key ] = $client->requestAsync( $hook->method, $hook->url, $parameters );
                $promises[ $key ]->then( function(ResponseInterface $response) use ($log, $logger) {
                    $logger( $log, $response );
                }, function(RequestException $e) use ($log, $logger) {
                    $logger( $log, $e->getResponse() );
                } );
            } );

            $results = Promise\settle( $promises )->wait();
        }

        return $results;
    }

}