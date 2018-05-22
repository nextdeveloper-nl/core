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


use PlusClouds\Core\Database\Models\Hook;

/**
 * Class HookTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class HookTransformer extends AbstractTransformer
{

    /**
     * @param Hook $hook
     *
     * @return array
     */
    public function transform(Hook $hook){
        return $this->buildPayload( [
            'id'         => $hook->id,
            'action'     => getHookAction( $hook->action ),
            'behavior'   => $hook->behavior,
            'url'        => $hook->url,
            'method'     => $hook->method,
            'parameters' => $hook->parameters,
            'position'   => $hook->position,
        ] );
    }

}