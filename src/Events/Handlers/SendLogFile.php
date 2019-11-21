<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Events\Handlers;


/**
 * Class SendLogFile
 * @package PlusClouds\Core\Events\Handlers
 */
class SendLogFile
{

    /**
     * @param $event
     */
    public function handle($event) {
        $id = $event->watchableData['id'];
        $message = $event->watchableData['message'];

        if( is_null( $message ) ) {
            $log = sprintf( "WatchableId : %s", $id );
        } else {
            $log = sprintf(
                "WatchableId : %s | %s",
                $id,
                $message
            );
        }

        app( 'WatchableJobLog' )->info( $log, [
            'class'    => substr( strrchr( $event->watchableData['class'], "\\" ), 1 ),
            'status'   => $event->watchableData['status'],
            'progress' => $event->watchableData['progress'],
        ] );
    }

}