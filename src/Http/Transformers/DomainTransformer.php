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

use League\Fractal\ParamBag;
use PlusClouds\Account\Http\Transformers\AccountTransformer;
use PlusClouds\Core\Database\Models\Domain;
use PlusClouds\IAAS\Database\Models\Network;

/**
 * Class DomainTransformer.
 *
 * @package PlusClouds\Core\Http\Transformers
 */
class DomainTransformer extends AbstractTransformer {
    /**
     * @var array
     */
    protected $availableIncludes = [ 'account', 'dnsService' ];

    /**
     * @param Domain $domain
     *
     * @return array
     */
    public function transform(Domain $domain) {
        $networks = Network::where('domain_id', $domain->id)->get();

        $dnsServiceId = null;

        if( class_exists('\PlusClouds\DNS\Database\Models\DnsService') ) {
            $dnsServiceId = $domain->dnsService->id_ref;
        }

        return $this->buildPayload( [
            'id'   => $domain->id_ref,
            'name' => $domain->name,
            'iam_service_id'    =>  null,
            'networks_attached'  =>  $networks->count(),
            'dns_domain_id' =>  $domain->dns_domain_id,
            'dns_service_id' =>  $dnsServiceId
        ] );
    }

    /**
     * @param MasterNode $masterNode
     * @param ParamBag|null $paramBag
     *
     * @return \League\Fractal\Resource\Item
     * @throws \Exception
     */
    public function includeAccount(Domain $domain, ParamBag $paramBag = null) {
        return $this->item( $domain->account, new AccountTransformer( $paramBag ) );
    }

    /**
     * @param MasterNode $masterNode
     * @param ParamBag|null $paramBag
     *
     * @return \League\Fractal\Resource\Item
     * @throws \Exception
     */
    public function includeDnsService(Domain $domain, ParamBag $paramBag = null) {
        if( class_exists('\PlusClouds\DNS\Database\Models\DnsService') ) {
            return $this->item($domain->dnsService, new \PlusClouds\DNS\Http\Transformers\DnsServiceTransformer($paramBag) );
        }
    }
}
