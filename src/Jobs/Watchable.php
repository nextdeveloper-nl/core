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


use PlusClouds\Core\Events\JobFailed;
use PlusClouds\Core\Events\JobFinished;
use PlusClouds\Core\Events\JobUpdated;
use Ramsey\Uuid\Uuid;

/**
 * Trait Watchable
 * @package PlusClouds\Core\Jobs
 */
trait Watchable
{

    /**
     * @var array
     */
    public $watchableData = [
        'id'           => null,
        'class'        => null,
        'status'       => null,
        'progress'     => 0,
        'message'      => null,
        'last_ping_at' => null,
        'started_at'   => null,
        'completed_at' => null,
    ];

    /**
     * @return $this
     * @throws \Exception
     */
    public function watch() {
        $this->setWatchableId();

        array_set( $this->watchableData, 'class', get_class( $this ) );

        return $this->markAsJobStarted();
    }

    /**
     * @return string
     */
    public function getClass() {
        return array_get( $this->watchableData, 'class' );
    }

    /**
     * @return string
     */
    public function getStatus() {
        return array_get( $this->watchableData, 'status' );
    }

    /**
     * @return string
     */
    public function getCurrentMessage() {
        return last( array_get( $this->watchableData, 'message' ) );
    }

    /**
     * @param string|null $id
     *
     * @return string
     * @throws \Exception
     */
    public function setWatchableId($id = null) {
        array_set( $this->watchableData, 'id', $id ?: Uuid::uuid4() );

        return $this->watchableData['id'];
    }

    /**
     * @return string
     * @throws \Exception
     */
    public function getWatchableId() {
        return array_get( $this->watchableData, 'id', $this->setWatchableId() );
    }

    /**
     * @param string $status
     *
     * @return $this
     */
    public function markStatus($status) {
        array_set( $this->watchableData, 'status', $status );

        return $this->pingWatcher();
    }

    /**
     * @return $this
     */
    public function markAsJobStarted() {
        array_set( $this->watchableData, 'status', 'RUNNING' );
        array_set( $this->watchableData, 'started_at', now()->toIso8601String() );

        return $this->pingWatcher();
    }

    /**
     * @return $this
     */
    public function markAsJobCompleted() {
        array_set( $this->watchableData, 'status', 'FINISHED' );
        array_set( $this->watchableData, 'completed_at', now()->toIso8601String() );

        event( new JobFinished( $this->watchableData ) );

        return $this->pingWatcher();
    }

    /**
     * @return $this
     */
    public function markAsJobFailed() {
        array_set( $this->watchableData, 'status', 'FAILED' );

        event( new JobFailed( $this->watchableData ) );

        return $this;
    }

    /**
     * @return int
     */
    public function getProgress() {
        return array_get( $this->watchableData, 'progress', 0 );
    }

    /**
     * @param int $percentage
     *
     * @return $this
     */
    public function setProgress($percentage) {
        array_set( $this->watchableData, 'progress', $percentage );

        return $this->pingWatcher( false );
    }

    /**
     * @param string|null $datetime
     *
     * @return $this
     */
    public function setLastPingAt($datetime = null) {
        array_set( $this->watchableData, 'last_ping_at', $datetime ?: now()->toIso8601String() );

        return $this;
    }

    /**
     * @param string $message
     *
     * @return $this
     */
    public function notifyWatcher($message) {
        array_set( $this->watchableData, 'message', $message );

        return $this->pingWatcher();
    }

    /**
     * @param bool $setAsMessageNull
     *
     * @return $this
     */
    public function pingWatcher($setAsMessageNull = true) {
        $this->setLastPingAt();

        event( new JobUpdated( $this->watchableData ) );

        if( $setAsMessageNull ) {
            array_set( $this->watchableData, 'message', null );
        }

        return $this;
    }

}