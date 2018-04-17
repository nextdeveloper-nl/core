<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Validation\Rules;

use Illuminate\Contracts\Validation\Rule;
use PlusClouds\Core\Database\Models\DisposableEmail as Disposable;

/**
 * Class DisposableEmail
 * @package PlusClouds\Core\Validation\Rules
 */
class DisposableEmail implements Rule
{

    /**
     * @param string $attribute
     * @param mixed $value
     *
     * @return bool
     * @throws \Exception
     */
    public function passes($attribute, $value) {
        return ! Disposable::check( $value );
    }

    /**
     * @return string
     */
    public function message() {
        return 'The :attribute must be a valid email address';
    }

}