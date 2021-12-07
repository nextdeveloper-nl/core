<?php

use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
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
 * @param float       $price
 * @param string      $foreignCurrencyCode
 * @param string      $domesticCurrencyCode
 * @param null|string $date
 *
 * @return float
 */
function currencyConverter($price, $foreignCurrencyCode, $domesticCurrencyCode, $date = null) {
    $start = microtime(true);

    if ($foreignCurrencyCode != $domesticCurrencyCode) {
        $date = (Carbon::parse($date) ?? now())->format('Y-m-d');

        // $domesticCurrency = \DB::table('exchange_rates')
        //     ->where('code', $domesticCurrencyCode)
        //     ->whereRaw("DATE_FORMAT(last_modified, '%Y-%m-%d') <= '{$date}'")
        //     ->orderBy('id', 'DESC')
        //     ->first();

	    //  Removed \ because it was creating problems with IDE. IDE dont recognize Laravel Facade classes!!!
        $domesticCurrency = DB::select("SELECT * FROM exchange_rates WHERE code = '{$domesticCurrencyCode}' AND DATE_FORMAT(last_modified, '%Y-%m-%d') <= '{$date}' ORDER BY id DESC LIMIT 1");
        $domesticCurrency = array_first($domesticCurrency);

        $domesticCurrencyRate = optional($domesticCurrency)->rate ?? 1;

        if ('TRY' != $foreignCurrencyCode) {
            // $foreignCurrency = ExchangeRate::where('code', $foreignCurrencyCode)
            //     ->whereRaw("DATE_FORMAT(last_modified, '%Y-%m-%d') <= '{$date}'")
            //     ->orderBy('id', 'DESC')
            //     ->first();

	        //  Removed \ because it was creating problems with IDE. IDE dont recognize Laravel Facade classes!!!
            $foreignCurrency = DB::select("SELECT * FROM exchange_rates WHERE code = '{$foreignCurrencyCode}' AND DATE_FORMAT(last_modified, '%Y-%m-%d') <= '{$date}' ORDER BY id DESC LIMIT 1");
            $foreignCurrency = array_first($foreignCurrency);

            $foreignCurrencyRate = optional($foreignCurrency)->rate ?? 1;
        } else {
            $foreignCurrencyRate = 1;
        }

        $parity = $foreignCurrencyRate / $domesticCurrencyRate;
        $price *= $parity;
    }

    $time = microtime(true) - $start;

    logger()->info('Currency convertion took: '.$time);

    return $price;
}

/**
 * @param float       $num
 * @param int         $decimals
 * @param null|string $decimalSeparator
 * @param null|string $thousandsSeparator
 *
 * @return float
 */
function formatNumber($num, $decimals = 0, $decimalSeparator = '.', $thousandsSeparator = ',') {
    $num = number_format($num, $decimals, $decimalSeparator, $thousandsSeparator);

    return (float)filter_var($num, FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
}

function fullTextWildcards($term)
{
    // semboller varsa kaldırıyoruz
    $reservedSymbols = ['-', '+', '<', '>', '@', '(', ')', '~'];
    $term = str_replace($reservedSymbols, '', $term);

    $words = explode(' ', $term);

    foreach ($words as $key => $word) {
        /*
         * büyük cümleler için araya * gerekli çünkü mysql küçükleri indekslemez
         *
         */
        if (strlen($word) >= 3) {
            $words[$key] = '*' . $word . '*';
        }
    }

    $searchTerm = implode(' ', $words);

    return $searchTerm;
}


function findObjectFromClassName($object,$objectId,$trait):array{

    //composer dosyasına erişiyoruz
    $content = file_get_contents('../composer.json');

    //composer dosyasını okuyoruz
    $loadedLibs = array_keys(json_decode($content,true)['require']);

    foreach ($loadedLibs as $pckName){

        //require edilen plusclouds paketlerini buluyoruz
        if (substr($pckName,0,4) === 'plus'){

            //bulunan pakette adını alıyoruz
            $moduleName = ucfirst(explode('/',$pckName)[1]);

            //crm komple uppercase yazıldığından dolayı crm gelirse komple büyük yazıyoruz
            if ($moduleName === 'Crm'){
                $moduleName = 'CRM';
            }

            //sonra bu paketin olabilecek pathini ayarlıyoruz
            $path = sprintf('PlusClouds\%s\Database\Models\%s',$moduleName,dashesToCamelCase($object,true));

            //ayarladığımız path gerçekten var moı diye bakıyoruz
            if (class_exists($path)){

                $class = new $path();

                //ayaraldığımız path var ise ve bu path taggable ise ilgili modeli buluyoruz
                if (array_key_exists(sprintf('PlusClouds\Core\Database\Traits\%s',$trait),class_uses_recursive($class))){

                    $objectId =  $class->findByRef($objectId)->id;

                    $object = $path;

                    return [$object,$objectId];

                }else{

                    logger()->error('[Tag|Attach] attaching failed because provided object not available for this action');

                    throw new \Exception('Provided object not available for this action');

                }
            }
        }
    }

    return [];
}