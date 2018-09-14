<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Requests;


/**
 * Class MailBatchSendRequest
 * @package PlusClouds\Core\Http\Requests
 */
class MailBatchSendRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can( 'core.mail@batch-send' );
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'subject' => 'required|max:255',
            'body'    => 'required',
        ];
    }

}