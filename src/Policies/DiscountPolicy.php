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
use PlusClouds\Core\Database\Models\Discount;

/**
 * Class DiscountPolicy
 * @package PlusClouds\Core\Policies
 */
class DiscountPolicy
{

    use HandlesAuthorization;

    /**
     * Aktif kullanıcı izni dahilinde bir indirimi silebilir.
     *
     * @param User $authUser
     * @param Discount $discount
     *
     * @return bool
     */
    public function destroy(User $authUser, Discount $discount) {
        return $authUser->can( 'core.discount@destroy' );
    }

}