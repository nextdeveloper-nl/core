<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use Stringy\StaticStringy as S;

/**
 * @param $str
 * @param string $replacement
 *
 * @return string
 */
function slugify($str, $replacement = '-') {
    return S::slugify( $str, $replacement );
}

/**
 * Turkish characters formats
 *
 * @param string $string
 *
 * @return string
 */
function ucwordsTr($string) {
    $chars = [
        'I' => 'ı',
        'Ğ' => 'ğ',
        'Ü' => 'ü',
        'Ş' => 'ş',
        'Ö' => 'ö',
        'Ç' => 'ç',
        'i' => 'İ',
    ];

    return mb_convert_case( strtr( $string, $chars ), MB_CASE_TITLE, 'UTF-8' );
}

/**
 * Turkish characters formats
 *
 * @param string $string
 *
 * @return string
 */
function upperCaseTr($string) {
    $chars = [
        'ı' => 'I',
        'ğ' => 'Ğ',
        'ü' => 'Ü',
        'ş' => 'Ş',
        'ö' => 'Ö',
        'ç' => 'Ç',
        'i' => 'İ',
    ];

    return mb_convert_case( strtr( $string, $chars ), MB_CASE_UPPER, 'UTF-8' );
}

/**
 * Turkish characters formats
 *
 * @param string $string
 *
 * @return string
 */
function lowerCaseTr($string) {
    $chars = [
        'I' => 'ı',
        'Ğ' => 'ğ',
        'Ü' => 'ü',
        'Ş' => 'ş',
        'Ö' => 'ö',
        'Ç' => 'ç',
        'İ' => 'i',
    ];

    return mb_convert_case( strtr( $string, $chars ), MB_CASE_LOWER, 'UTF-8' );
}

/**
 * Masks of the credit card number
 *
 * @param string $cardNumber
 * @param string $maskingChar
 *
 * @return string
 */
function maskCreditCard($cardNumber, $maskingChar = 'x') {
    $numbers = str_split( $cardNumber, 4 );
    $length = sizeof( $numbers );

    foreach( $numbers as $key => $number ) {
        if( $key === 0 ) {
            $numbers[ $key ] = substr( $number, 0, 1 ).str_repeat( $maskingChar, ( strlen( $number ) - 1 ) );
        } else {
            if( $key !== ( $length - 1 ) ) {
                $numbers[ $key ] = str_repeat( $maskingChar, strlen( $number ) );
            }
        }
    }

    return implode( '-', $numbers );
}