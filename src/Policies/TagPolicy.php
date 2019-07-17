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
use PlusClouds\Core\Common\Enums\TagType;
use PlusClouds\Core\Database\Models\Tag;

/**
 * Class TagPolicy
 * @package PlusClouds\Core\Policies
 */
class TagPolicy
{

    use HandlesAuthorization;

    /**
     * @param User $authUser
     * @param Tag $tag
     *
     * @return bool
     */
    public function tagDestroy(User $authUser, Tag $tag) {
        return $tag->type == TagType::APPLICATION
            && $authUser->id == getAccountOwner( $tag->account )->id;
    }

}