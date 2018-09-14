<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Policies;


use Illuminate\Auth\Access\HandlesAuthorization;
use PlusClouds\Account\Database\Models\User;
use PlusClouds\Core\Database\Models\Domain;

/**
 * Class DomainPolicy
 * @package PlusClouds\Core\Policies
 */
class DomainPolicy
{

    use HandlesAuthorization;

    /**
     * Aktif kullanıcı izni dahilinde bir alan adı bilgilerini güncelleyebilir.
     *
     * @param User $authUser
     * @param Domain $domain
     *
     * @return bool
     */
    public function update(User $authUser, Domain $domain) {
        return $authUser->can( 'core.domain@update' )
            && getMasterAccount( $authUser )->id == $domain->account_id;
    }

    /**
     * Aktif kullanıcı izni dahilinde bir alan adını silebilir.
     *
     * @param User $authUser
     * @param Domain $domain
     *
     * @return bool
     */
    public function destroy(User $authUser, Domain $domain) {
        return $authUser->can( 'core.domain@destroy' )
            && getMasterAccount( $authUser )->id == $domain->account_id;
    }

}