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
 * Class EmailTemplateUpdateRequest
 * @package PlusClouds\Core\Http\Requests
 */
class EmailTemplateUpdateRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize() {
        return $this->user()->can( 'core.emailtemplate@update' );
    }

    /**
     * @return array
     */
    public function rules() {
        return [
            'name'        => 'required|exists:email_templates,name|max:255',
            'description' => 'required|max:255',
            'body'        => 'required',
            'locale'      => 'required|exists:countries,locale,locale,NOT_NULL',
        ];
    }

}