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
 * Class HookResource
 * @package PlusClouds\Core\Http\Resources
 */
class HookResource extends AbstractResource
{

    /**
     * @param \Illuminate\Http\Request $request
     *
     * @return array
     */
    public function toArray($request) {
        return $this->filterFields( [
            'id'         => $this->id_ref,
            'action'     => $this->action,
            'behavior'   => $this->behavior,
            'url'        => $this->url,
            'method'     => $this->method,
            'parameters' => $this->parameters,
            'position'   => $this->position,
        ] );
    }

}