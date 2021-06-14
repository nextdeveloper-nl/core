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
 * Class Domain.
 *
 * @package PlusClouds\Core\Validation\Rules
 */
class Domain implements Rule {
    /**
     * Hostnames are composed of a series of labels concatenated with dots.
     * Each label is 1 to 63 characters long, and may contain: the ASCII letters a-z and A-Z, the digits 0-9, and the hyphen ('-').
     * Additionally: labels cannot start or end with hyphens (RFC 952)
     * labels can start with numbers (RFC 1123)
     * trailing dot is not allowed max length of ascii hostname including dots is 253 characters TLD (last label) is at least 2 characters and only ASCII letters we want at least 1 level above TLD.
     *
     * @param string $attribute
     * @param string $value
     *
     * @return bool
     */
    public function passes($attribute, $value) {
        return preg_match('/(?=^.{4,253}$)(^((?!-)[a-zA-Z0-9-]{0,62}[a-zA-Z0-9]\.)+[a-zA-Z]{2,63}$)/i', $value);
    }

    /**
     * @return string
     */
    public function message() {
        return 'The :attribute must be a valid domain';
    }
}
