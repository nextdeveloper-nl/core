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

/**
 * Class Locale.
 *
 * @package PlusClouds\Core\Validation\Rules
 */
class Locale implements Rule {
    /**
     * @param string $attribute
     * @param mixed  $value
     *
     * @return bool
     */
    public function passes($attribute, $value) {
        return in_array($value, config('core.locales.availables'));
    }

    /**
     * @return string
     */
    public function message() {
        return 'The :attribute must be a valid locale';
    }
}
