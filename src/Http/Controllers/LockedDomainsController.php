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
     * Alan adını kullanıma kapatır.
     *
     * @param Domain $domain
     *
     * @return mixed
     */
    public function update(Domain $domain) {
        $domain->update( [ 'is_locked' => true ] );

        return $this->noContent();
    }

    /**
     * Alan adını kullanıma açar.
     *
     * @param Domain $domain
     *
     * @return mixed
     */
    public function destroy(Domain $domain) {
        $domain->update([ 'is_locked' => false ]);

        return $this->noContent();
    }

}