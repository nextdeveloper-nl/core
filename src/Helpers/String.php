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
    return S::slugify($str, $replacement);
}

/**
 * Turkish characters formats.
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

    return mb_convert_case(strtr($string, $chars), MB_CASE_TITLE, 'UTF-8');
}

/**
 * Turkish characters formats.
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

    return mb_convert_case(strtr($string, $chars), MB_CASE_UPPER, 'UTF-8');
}

/**
 * Turkish characters formats.
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

    return mb_convert_case(strtr($string, $chars), MB_CASE_LOWER, 'UTF-8');
}

/**
 * Masks of the credit card number.
 *
 * @param string $cardNumber
 * @param string $maskingChar
 *
 * @return string
 */
function maskCreditCard($cardNumber, $maskingChar = 'x') {
    $numbers = str_split($cardNumber, 4);
    $length = sizeof($numbers);

    foreach ($numbers as $key => $number) {
        if (0 === $key) {
            $numbers[$key] = substr($number, 0, 1).str_repeat($maskingChar, (strlen($number) - 1));
        } else {
            if ($key !== ($length - 1)) {
                $numbers[$key] = str_repeat($maskingChar, strlen($number));
            }
        }
    }

    return implode('-', $numbers);
}

/**
 * @param $string
 * @param int    $width
 * @param bool   $cut
 * @param string $break
 *
 * @return null|\Illuminate\Support\Collection
 */
function utf8_wordwrap($string, $width = 75, $cut = false, $break = "\n") {
    if ($cut) {
        // Match anything 1 to $width chars long followed by whitespace or EOS,
        // otherwise match anything $width chars long
        $search = '/(.{1,'.$width.'})(?:\s|$)|(.{'.$width.'})/uS';
        $replace = '$1$2'.$break;
    } else {
        // Anchor the beginning of the pattern with a lookahead
        // to avoid crazy backtracking when words are longer than $width
        $search = '/(?=\s)(.{1,'.$width.'})(?:\s|$)/uS';
        $replace = '$1'.$break;
    }

    $lines = collect(explode($break, rtrim(preg_replace($search, $replace, $string), $break)))->map(function ($line) {
        return trim($line);
    })->filter(function ($line) {
        return ! empty($line);
    });

    return $lines->count() > 0 ? $lines : null;
}

/**
 * @param array|object|string $input
 */
function utf8_encode_deep(&$input) {
    if (is_string($input)) {
        $input = utf8_encode($input);
    } elseif (is_array($input)) {
        foreach ($input as &$value) {
            utf8_encode_deep($value);
        }

        unset($value);
    } elseif (is_object($input)) {
        $vars = array_keys(get_object_vars($input));

        foreach ($vars as $var) {
            utf8_encode_deep($input->{$var});
        }
    }
}

/**
 * @param mixed $param
 *
 * @return bool
 */
function isJsonString($param) {
    if (is_string($param)) {
        @json_decode($param);

        return JSON_ERROR_NONE == json_last_error();
    }

    return false;
}


function dashesToCamelCase($string, $capitalizeFirstCharacter = false)
{

    $str = str_replace(' ', '', ucwords(str_replace('-', ' ', $string)));

    if (!$capitalizeFirstCharacter) {
        $str[0] = strtolower($str[0]);
    }

    return $str;
}