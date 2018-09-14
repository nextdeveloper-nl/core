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
use PlusClouds\Core\Database\Models\EmailTemplate;

/**
 * Class EmailTemplatePolicy
 * @package PlusClouds\Core\Policies
 */
class EmailTemplatePolicy
{

    use HandlesAuthorization;

    /**
     * Aktif kullanıcı izni dahilinde bir e-posta şablonunu silebilir.
     *
     * @param User $authUser
     * @param EmailTemplate $template
     *
     * @return bool
     */
    public function destroy(User $authUser, EmailTemplate $template) {
        return $authUser->can( 'core.emailtemplate@destroy' );
    }

}