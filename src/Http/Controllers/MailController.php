<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Controllers;


use Illuminate\Database\Eloquent\ModelNotFoundException;
use PlusClouds\Core\Http\Requests\MailBatchSendRequest;
use PlusClouds\Core\Http\Requests\MailSendRequest;

/**
 * Class MailController
 * @package PlusClouds\Core\Http\Controllers
 */
class MailController extends AbstractController
{

    /**
     * @name Send a Mail to a specific User
     *
     * @param MailSendRequest $request
     *
     * @return mixed
     * @throws \Throwable
     */
    public function send(MailSendRequest $request) {
        throw_if( class_exists( ( $class = 'PlusClouds\Account\Database\Models\User' ) ), ModelNotFoundException::class, 'Account module do not exists..' );

        $user = $class::where( 'email', $request->get( 'to' ) )->firstOrFail();

        $template = view( [ 'template' => $request->get( 'body' ) ], [ 'user' => $user ] );

        // todo : E-posta gönderme kodu yazılacak. (MailGun mu kullanılacak???)

        return $this->noContent();
    }

    /**
     * @name Send a message to multiple people.
     *
     * @param MailBatchSendRequest $request
     *
     * @return mixed
     */
    public function batchSend(MailBatchSendRequest $request) {
        dispatch( new MailBatchSendRequest(
            $request->get( 'subject' ),
            $request->get( 'body' )
        ) );

        return $this->noContent();
    }

}