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


use PlusClouds\Core\Database\Models\Domain;

/**
 * Class DomainTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class DomainTransformer extends AbstractTransformer
{

    /**
     * @param Domain $domain
     *
     * @return array
     */
    public function transform(Domain $domain) {
        return $this->buildPayload( [
            'id'   => $domain->id_ref,
            'name' => $domain->name,
        ] );
    }

}