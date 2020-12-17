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
 * Class EmailTemplateStoreRequest
 * @package PlusClouds\Core\Http\Requests
 */
class EmailTemplateStoreRequest extends AbstractFormRequest
{

    /**
     * @return bool
     */
    public function authorize()
    {
        return true;
        return $this->user()->can('core.emailtemplate@store');
    }

    /**
     * @return array
     */
    public function rules()
    {
        return [
            'name'        => 'required|max:255',
            'description' => 'required|max:255',
            'body'        => 'required',
            'subject'     =>  'required',
            'template_locale'      => 'exists:countries,locale',
        ];
    }
}
