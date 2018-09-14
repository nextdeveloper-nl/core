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
use PlusClouds\Core\Database\Models\Country;

/**
 * Class CountryPolicy
 * @package PlusClouds\Core\Policies
 */
class CountryPolicy
{

    use HandlesAuthorization;

    /**
     * Aktif kullanıcı izni dahilinde bir ülkeyi silebilir.
     *
     * @param User $authUser
     * @param Country $country
     *
     * @return bool
     */
    public function destroy(User $authUser, Country $country) {
        return $authUser->can( 'core.category@destroy' );
    }

}