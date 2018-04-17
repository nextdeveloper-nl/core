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
 * Class MacAddress
 * @package PlusClouds\Core\Validation\Rules
 */
class MacAddress implements Rule
{

    /**
     * @param string $attribute
     * @param mixed $value
     *
     * @return bool
     */
    public function passes($attribute, $value) {
        return (bool) preg_match( '/^(([0-9a-fA-F]{2}-){5}|([0-9a-fA-F]{2}:){5})[0-9a-fA-F]{2}$/', $value );
    }

    /**
     * @return string
     */
    public function message() {
        return 'The :attribute must be a valid mac address';
    }

}