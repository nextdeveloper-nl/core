<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Resources;


/**
 * Class EmailTemplateResource
 * @package PlusClouds\Core\Http\Resources
 */
class EmailTemplateResource extends AbstractResource
{

    /**
     * @param \Illuminate\Http\Request $request
     *
     * @return array
     */
    public function toArray($request) {
        return $this->filterFields( [
            'id'          => $this->id_ref,
            'name'        => $this->name,
            'description' => $this->description,
            'body'        => $this->body,
        ] );
    }

}