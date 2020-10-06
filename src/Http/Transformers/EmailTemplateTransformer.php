<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Transformers;


use PlusClouds\Core\Database\Models\EmailTemplate;

/**
 * Class EmailTemplateTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class EmailTemplateTransformer extends AbstractTransformer
{

    /**
     * @param EmailTemplate $template
     *
     * @return array
     */
    public function transform(EmailTemplate $template) {
        return $this->buildPayload( [
        	'id'          => $template->id_ref,
            'name'        => $template->name,
            'description' => $template->description,
            'body'        => $template->body,
            'locale'      => $template->locale,
        ] );
    }

}