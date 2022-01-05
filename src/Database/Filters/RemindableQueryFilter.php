<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Filters;

use PlusClouds\Account\Database\Models\User;

/**
 * Class CategoryQueryFilter
 * @package PlusClouds\Core\Database\Filters
 */
class RemindableQueryFilter extends AbstractQueryFilter
{


    /**
     *
     * @param string $userRef
     *
     * @return mixed
     */
    public function user($userRef)
    {
        $user = User::findByRef($userRef);

        return $this->builder->where('user_id',$user->id);
    }


}
