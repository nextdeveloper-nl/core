<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

/**
 * Generate new random code
 *
 * @param int $length
 *
 * @return int
 */
function generateRandomCode($length = 4) {
    $chars = str_shuffle( 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' );

    return substr( $chars, 1, $length );
//
//    $min = pow( 10, ( $digits - 1 ) );
//    $max = ( $min * 10 ) - 1;
//
//    return mt_rand( $min, $max );
}

/**
 * Generate new random number
 *
 * @param int $min
 * @param int $max
 *
 * @return double
 */
function customRnd($min = 1, $max = 2) {
    return ( $min + ( $max - $min ) * ( mt_rand() / mt_getrandmax() ) );
}

/**
 * Generate new random uuid
 *
 * @param null|string $prefix
 *
 * @return string
 */
function genUuid($prefix = null) {
    if( ! is_null( $prefix ) ) {
        $length = strlen( $prefix );

        if( $length > 3 ) {
            $prefix = substr( $prefix, 0, 3 );
        } elseif( $length < 3 ) {
            $prefix = str_pad( $prefix, 3, '0', STR_PAD_LEFT );
        }
    }

    $uuid = sprintf( '%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
        // 32 bits for "time_low"
        mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ),
        // 16 bits for "time_mid"
        mt_rand( 0, 0xffff ),
        // 16 bits for "time_hi_and_version",
        // four most significant bits holds version number 4
        mt_rand( 0, 0x0fff ) | 0x4000,
        // 16 bits, 8 bits for "clk_seq_hi_res",
        // 8 bits for "clk_seq_low",
        // two most significant bits holds zero and one for variant DCE1.1
        mt_rand( 0, 0x3fff ) | 0x8000,
        // 48 bits for "node"
        mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff )
    );

    return $prefix ? sprintf( '%s-%s', $prefix, $uuid ) : $uuid;
}

/**
 * Convert a delimited string into an array of tag strings
 *
 * @param string|array $tags
 *
 * @return array
 */
function buildTagArray($tags) {
    if( is_array( $tags ) ) {
        return $tags;
    }

    if( is_string( $tags ) ) {
        return preg_split(
            '#['.preg_quote( config( 'core.taggable.delimiters' ), '#' ).']#',
            $tags,
            null,
            PREG_SPLIT_NO_EMPTY
        );
    }

    return (array) $tags;
}

/**
 * Convert a delimited string into an array of normalized tag strings
 *
 * @param string|array $tags
 *
 * @return array
 */
function normalizeTag($tags) {
    $tags = buildTagArray( $tags );

    return array_map( 'ucwordsTr', $tags );
}

/**
 * Get an array from argument
 *
 * @param int|string|array $arg
 *
 * @return array
 */
function getArrayFrom($arg) {
    return ! is_array( $arg ) ? preg_split( '/ ?[,|] ?/', $arg ) : $arg;
}

/**
 * @param array $data
 *
 * @return array
 */
function customFilter(array $data) {
    return array_filter( $data, function($v) {
        return $v !== false && ! is_null( $v ) && ( $v != '' || $v == '0' );
    } );
}