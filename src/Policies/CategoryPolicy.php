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
use PlusClouds\Core\Database\Models\Category;

/**
 * Class CategoryPolicy
 * @package PlusClouds\Core\Policies
 */
class CategoryPolicy
{

    use HandlesAuthorization;

    /**
     * Aktif kullanıcı izni dahilinde bir kategoriyi silebilir.
     *
     * @param User $authUser
     * @param Category $category
     *
     * @return bool
     */
    public function destroy(User $authUser, Category $category) {
        return $authUser->can( 'core.category@destroy' )
            && $authUser->id == $category->user_id;
    }

}