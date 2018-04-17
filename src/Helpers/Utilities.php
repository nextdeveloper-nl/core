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
 * @param int $digits
 *
 * @return int
 */
function generateRandomCode($digits = 4) {
    $min = pow( 10, ( $digits - 1 ) );
    $max = ( $min * 10 ) - 1;

    return mt_rand( $min, $max );
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