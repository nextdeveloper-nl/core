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
 * Class NiN
 * @package PlusClouds\Core\Validation\Rules
 */
class NiN implements Rule
{

    /**
     * @param string $attribute
     * @param mixed $value
     *
     * @return bool
     */
    public function passes($attribute, $value) {
        if( strlen( $value ) != 11 || (int) $value[0] === 0 || ! ctype_digit( $value ) || (int) substr( $value, 0, 9 ) < 100000001 ) {
            return false;
        }

        $first = $last = $all = 0;

        for( $i = 0; $i < 9; $i = $i + 2 ) {
            $first += $value[ $i ];
        }

        for( $i = 1; $i < 9; $i = $i + 2 ) {
            $last += $value[ $i ];
        }

        for( $i = 0; $i < 10; $i++ ) {
            $all += $value[ $i ];
        }

        $first *= 7 - $last;

        if( ( ( $first % 10 ) !== (int) $value[9] ) && ( ( $all % 10 ) !== (int) $value[10] ) ) {
            return false;
        }

        return true;
    }

    /**
     * @return string
     */
    public function message() {
        return 'The :attribute must be a valid NiN (National Identity Number)';
    }


}