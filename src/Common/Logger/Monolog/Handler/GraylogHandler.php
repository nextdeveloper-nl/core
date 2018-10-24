<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Logger\Monolog\Handler;


use Monolog\Handler\AbstractProcessingHandler;
use Monolog\Logger;
use Gelf\Transport\UdpTransport;
use Gelf\Message;
use Gelf\Publisher;

/**
 * Class GraylogHandler
 * @package PlusClouds\Core\Common\Logger\Monolog\Handler
 */
class GraylogHandler extends AbstractProcessingHandler
{

    /**
     * @var UdpTransport
     */
    protected $transport;

    /**
     * @var Publisher
     */
    protected $publisher;

    /**
     * GraylogHandler constructor.
     *
     * @param int $level
     * @param bool $bubble
     */
    public function __construct(int $level = Logger::DEBUG, bool $bubble = true) {
        $this->transport = new UdpTransport( env( 'GRAYLOG_HOST' ), env( 'GRAYLOG_UDP_PORT' ), UdpTransport::CHUNK_SIZE_LAN );

        $this->publisher = new Publisher();
        $this->publisher->addTransport( $this->transport );

        parent::__construct( $level, $bubble );
    }

    /**
     * @param array $record
     */
    public function write(array $record) {
        $this->publisher->publish( $record['formatted'] );
    }

}