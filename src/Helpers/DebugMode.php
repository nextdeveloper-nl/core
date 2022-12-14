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

use Monolog\Formatter\GelfMessageFormatter;
use Monolog\Handler\StreamHandler;
use Monolog\Logger;
use PlusClouds\Core\Common\Logger\Monolog\Handler\GraylogHandler;

/**
 * Class DebugMode.
 *
 * @package PlusClouds\Core\Helpers
 */
final class DebugMode {
    /**
     * @var array
     */
    private $channels = [];

    /**
     * @var string
     */
    private $channel = 'laravel';

    /**
     * @param $value
     *
     * @return $this
     */
    public function setChannel($value) {
        $this->channel = $value;

        return $this;
    }

    /**
     * @param string $channel
     * @param int    $level
     * @param string $message
     * @param array  $context
     *
     * @throws \Exception
     *
     * @return mixed
     */
    public function log($channel, $level, $message, $context = []) {
        // Add the logger if it doesn't exist
        if ( ! isset($this->channels[$channel])) {
            if (true === (bool)env('GRAYLOG_ENABLED', false)) {
                $handler = new GraylogHandler();
                $handler->setFormatter(new GelfMessageFormatter());
            } else {
                $handler = new StreamHandler(
                    storage_path().DIRECTORY_SEPARATOR.'logs'.DIRECTORY_SEPARATOR.$channel.'.log'
                );

                $handler->setFormatter(new \Monolog\Formatter\LineFormatter(null, null, true, true));
            }

            $this->addChannel($channel, $handler);
        }

        // LogToChannels the record
        return $this->channels[$channel]->{Logger::getLevelName($level)}($message, $context);
    }

    /**
     * @param string $channelName
     * @param $handler
     * @param null|string $path
     *
     * @throws \Exception
     */
    public function addChannel($channelName, $handler) {
        if (isset($this->channels[$channelName])) {
            throw new \Exception('This channel already exists');
        }

        $this->channels[$channelName] = new Logger($channelName);
        $this->channels[$channelName]->pushProcessor(new \Monolog\Processor\WebProcessor());
        $this->channels[$channelName]->pushProcessor(new \Monolog\Processor\MemoryUsageProcessor());
        $this->channels[$channelName]->pushProcessor(new \Monolog\Processor\MemoryPeakUsageProcessor());
        $this->channels[$channelName]->pushHandler($handler);
    }

    /**
     * @param string $message
     * @param array  $context
     *
     * @throws \Exception
     */
    public function emergency($message, array $context = []) {
        $this->log($this->channel, Logger::EMERGENCY, $message, $context);
    }

    /**
     * @param string $message
     * @param array  $context
     *
     * @throws \Exception
     */
    public function alert($message, array $context = []) {
        $this->log($this->channel, Logger::ALERT, $message, $context);
    }

    /**
     * @param string $message
     * @param array  $context
     *
     * @throws \Exception
     */
    public function critical($message, array $context = []) {
        $this->log($this->channel, Logger::CRITICAL, $message, $context);
    }

    /**
     * @param string $message
     * @param array  $context
     *
     * @throws \Exception
     */
    public function error($message, array $context = []) {
        $this->log($this->channel, Logger::ERROR, $message, $context);
    }

    /**
     * @param string $message
     * @param array  $context
     *
     * @throws \Exception
     */
    public function warning($message, array $context = []) {
        $this->log($this->channel, Logger::WARNING, $message, $context);
    }

    /**
     * @param string $message
     * @param array  $context
     *
     * @throws \Exception
     */
    public function notice($message, array $context = []) {
        $this->log($this->channel, Logger::NOTICE, $message, $context);
    }

    /**
     * @param string $message
     * @param array  $context
     *
     * @throws \Exception
     */
    public function info($message, array $context = []) {
        $this->log($this->channel, Logger::INFO, $message, $context);
    }

    /**
     * @param string $message
     * @param array  $context
     *
     * @throws \Exception
     */
    public function debug($message, array $context = []) {
        $this->log($this->channel, Logger::DEBUG, $message, $context);
    }
}
