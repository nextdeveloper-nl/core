<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Helpers;


use Illuminate\Contracts\Logging\Log;

/**
 * Class DebugMode
 * @package PlusClouds\Core\Helpers
 */
final class DebugMode
{

    /**
     * @var Log
     */
    private $logger;

    /**
     * @var bool|mixed
     */
    private $debug = false;

    /**
     * DebugMode constructor.
     *
     * @param Log $logger
     */
    public function __construct(Log $logger) {
        $this->logger = $logger;
        $this->debug = env( 'APP_DEBUG' );
    }

    /**
     * @param $name
     * @param $arguments
     */
    public function __call($name, $arguments) {
        if( ! method_exists( $this, $name ) ) {
            throw new \InvalidArgumentException( sprintf( 'Call to undefined method %s::%s()', __CLASS__, $name ) );
        }

        if( $this->debug ) {
            call_user_func_array( [ $this, $name ], $arguments );
        }
    }

    /**
     * @param $message
     * @param array $context
     */
    protected function emergency($message, array $context = []) {
        $this->logger->{__FUNCTION__}( $message, $context );
    }

    /**
     * @param $message
     * @param array $context
     */
    protected function alert($message, array $context = []) {
        $this->logger->{__FUNCTION__}( $message, $context );
    }

    /**
     * @param $message
     * @param array $context
     */
    protected function critical($message, array $context = []) {
        $this->logger->{__FUNCTION__}( $message, $context );
    }

    /**
     * @param $message
     * @param array $context
     */
    protected function error($message, array $context = []) {
        $this->logger->{__FUNCTION__}( $message, $context );
    }

    /**
     * @param $message
     * @param array $context
     */
    protected function warning($message, array $context = []) {
        $this->logger->{__FUNCTION__}( $message, $context );
    }

    /**
     * @param $message
     * @param array $context
     */
    protected function notice($message, array $context = []) {
        $this->logger->{__FUNCTION__}( $message, $context );
    }

    /**
     * @param $message
     * @param array $context
     */
    protected function info($message, array $context = []) {
        $this->logger->{__FUNCTION__}( $message, $context );
    }

    /**
     * @param $message
     * @param array $context
     */
    protected function debug($message, array $context = []) {
        $this->logger->{__FUNCTION__}( $message, $context );
    }

}