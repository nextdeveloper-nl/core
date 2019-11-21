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
use PlusClouds\IAAS\Database\Models\Network;

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
        $networks = Network::where('domain_id', $domain->id)->get();

        return $this->buildPayload( [
            'id'   => $domain->id_ref,
            'name' => $domain->name,
            'core_directory_id'    =>  null,
            'networks_attached'  =>  $networks->count(),
            'dns_id' =>  null,
            'netgateway_id' =>  null
        ] );
    }
}