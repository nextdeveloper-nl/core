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
use PlusClouds\Core\Database\Models\Hook;

/**
 * Class HookPolicy
 * @package PlusClouds\Core\Policies
 */
class HookPolicy
{

    use HandlesAuthorization;

    /**
     * Aktif kullanıcı izni dahilinde bir kancayı silebilir.
     *
     * @param User $authUser
     * @param Hook $hook
     *
     * @return bool
     */
    public function destroy(User $authUser, Hook $hook) {
        return $authUser->can( 'hook@destroy' )
            && getMasterAccount( $authUser )->id == $hook->vendor_id;
    }

}