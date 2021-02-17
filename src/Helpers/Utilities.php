<?php

use PlusClouds\Core\Database\Models\ExchangeRate;

/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * @param mixed $length
 */

/**
 * Generate new random code.
 *
 * @param int $length
 *
 * @return int
 */
function generateRandomCode($length = 4) {
    $chars = str_shuffle('abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');

    return substr($chars, 1, $length);
//
//    $min = pow( 10, ( $digits - 1 ) );
//    $max = ( $min * 10 ) - 1;
//
//    return mt_rand( $min, $max );
}

/**
 * @param int $length
 *
 * @return bool|string
 */
function generateRandomString($length = 4) {
    $chars = str_shuffle('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');

    return substr($chars, 1, $length);
}

/**
 * @param int $length
 *
 * @return bool|int
 */
function generateRandomNumber($length = 4) {
    $min = (10 ** $length) / 10; // 100...
    $max = (10 ** $length) - 1;  // 999...

    return mt_rand($min, $max);
}

/**
 * Generate new random number.
 *
 * @param int $min
 * @param int $max
 *
 * @return float
 */
function customRnd($min = 1, $max = 2) {
    return  $min + ($max - $min) * (mt_rand() / mt_getrandmax());
}

/**
 * Generate new random uuid.
 *
 * @param null|string $prefix
 *
 * @return string
 */
function genUuid($prefix = null) {
    if ( ! is_null($prefix)) {
        $length = strlen($prefix);

        if ($length > 3) {
            $prefix = substr($prefix, 0, 3);
        } elseif ($length < 3) {
            $prefix = str_pad($prefix, 3, '0', STR_PAD_LEFT);
        }
    }

    $uuid = sprintf('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
        // 32 bits for "time_low"
        mt_rand(0, 0xffff), mt_rand(0, 0xffff),
        // 16 bits for "time_mid"
        mt_rand(0, 0xffff),
        // 16 bits for "time_hi_and_version",
        // four most significant bits holds version number 4
        mt_rand(0, 0x0fff) | 0x4000,
        // 16 bits, 8 bits for "clk_seq_hi_res",
        // 8 bits for "clk_seq_low",
        // two most significant bits holds zero and one for variant DCE1.1
        mt_rand(0, 0x3fff) | 0x8000,
        // 48 bits for "node"
        mt_rand(0, 0xffff), mt_rand(0, 0xffff), mt_rand(0, 0xffff)
    );

    return $prefix ? sprintf('%s-%s', $prefix, $uuid) : $uuid;
}

/**
 * Convert a delimited string into an array of tag strings.
 *
 * @param array|string $tags
 *
 * @return array
 */
function buildTagArray($tags) {
    if (is_array($tags)) {
        return $tags;
    }

    if (is_string($tags)) {
        return preg_split(
            '#['.preg_quote(config('core.taggable.delimiters'), '#').']#',
            $tags,
            null,
            PREG_SPLIT_NO_EMPTY
        );
    }

    return (array)$tags;
}

/**
 * Convert a delimited string into an array of normalized tag strings.
 *
 * @param array|string $tags
 *
 * @return array
 */
function normalizeTag($tags) {
    $tags = buildTagArray($tags);

    return array_map('trim', array_map('ucwordsTr', $tags));
}

/**
 * Get an array from argument.
 *
 * @param array|int|string $arg
 *
 * @return array
 */
function getArrayFrom($arg) {
    return ! is_array($arg) ? preg_split('/ ?[,|] ?/', $arg) : $arg;
}

/**
 * @param array $data
 *
 * @return array
 */
function customFilter(array $data) {
    return array_filter($data, function ($v) {
        return false !== $v && ! is_null($v) && ('' != $v || '0' == $v);
    });
}

/**
 * @param float $min
 * @param float $max
 *
 * @return float|int
 */
function randomFloat($min, $max) {
    return  $min + lcg_value() * (abs($max - $min));
}

/**
 * @param float  $price
 * @param string $foreignCurrencyCode
 * @param string $domesticCurrencyCode
 *
 * @return float
 */
function currencyConverter($price, $foreignCurrencyCode, $domesticCurrencyCode) {
    if ($foreignCurrencyCode != $domesticCurrencyCode) {
        $date = now()->subDay()->format('Y-m-d');

        $domesticCurrency = ExchangeRate::where('code', $domesticCurrencyCode)
            ->whereDate('last_modified', '>=', $date)
            ->orderBy('id', 'DESC')
            ->first();

        $domesticCurrencyRate = optional($domesticCurrency)->rate ?? 1;

        if ('TRY' != $foreignCurrencyCode) {
            $foreignCurrency = ExchangeRate::where('code', $foreignCurrencyCode)
                ->whereDate('last_modified', '>=', $date)
                ->orderBy('id', 'DESC')
                ->first();

            $foreignCurrencyRate = optional($foreignCurrency)->rate ?? 1;
        } else {
            $foreignCurrencyRate = 1;
        }

        $parity = $foreignCurrencyRate / $domesticCurrencyRate;
        $price *= $parity;
    }

    return $price;
}
