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


use Illuminate\Contracts\Queue\ShouldQueue;

/**
 * Class MailBatchSendJob
 * @package PlusClouds\Core\Jobs
 */
class MailBatchSendJob extends AbstractJob implements ShouldQueue
{

    /**
     * E-posta konusu
     *
     * @var string
     */
    protected $subject;

    /**
     * E-posta detayı
     *
     * @var string
     */
    protected $body;

    /**
     * MailBatchSendJob constructor.
     *
     * @param $subject
     * @param $body
     */
    public function __construct($subject, $body) {
        $this->subject = $subject;
        $this->body = $body;
    }

    /**
     * @return void
     */
    public function handle() {
        // @todo Toplu e-posta gönderme kodu yazılacak. (MailGun mu kullanılacak???)
    }

}