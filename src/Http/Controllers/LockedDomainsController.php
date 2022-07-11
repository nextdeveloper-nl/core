<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Controllers;


use PlusClouds\Core\Database\Models\Domain;

/**
 * Class LockedDomainsController
 * @package PlusClouds\Core\Http\Controllers
 */
class LockedDomainsController extends AbstractController
{

    /**
     * @name Locks the usage for a Domain
     *
     * @param Domain $domain
     *
     * @return mixed
     * @throws \Illuminate\Auth\Access\AuthorizationException
     */
    public function update(Domain $domain) {
        $this->authorize( 'update', $domain );

        $domain->update( [ 'is_locked' => true ] );

        return $this->noContent();
    }


    /**
     * @name Deletes a log on a Domain
     *
     * @param Domain $domain
     *
     * @return mixed
     * @throws \Illuminate\Auth\Access\AuthorizationException
     */
    public function destroy(Domain $domain) {
        $this->authorize( 'update', $domain );

        $domain->update( [ 'is_locked' => false ] );

        return $this->noContent();
    }

}