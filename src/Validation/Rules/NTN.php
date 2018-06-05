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
 * Class NTN
 * @package PlusClouds\Core\Validation\Rules
 */
class NTN implements Rule
{

    /**
     * @param string $attribute
     * @param mixed $value
     *
     * @return bool
     */
    public function passes($attribute, $value) {
        $value = (string) $value;

        if( ( $length = strlen( $value ) ) != 10 ) {
            return false;
        }

        $n = $m = [];

        for( $i = 0; $i < ( $length - 1 ); $i++ ) {
            $x = $i + 1;

            $n[ $i ] = ( $value[ $i ] + 10 - $x ) % 10;

            if( $n[ $i ] != 9 ) {
                $m[ $i ] = ( $n[ $i ] * pow( 2, ( 10 - $x ) ) ) % 9;
            } else {
                $m[ $i ] = 9;
            }
        }

        $m = ( 10 - ( array_sum( $m ) % 10 ) ) % 10;

        return $m == substr( $value, $length - 1, 1 );
    }

    /**
     * @return string
     */
    public function message() {
        return 'The :attribute must be a valid NTN (National Tax Number)';
    }


}