<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use PlusClouds\Core\Database\Models\EmailTemplate;

/**
 * E-posta şablon bilgisini döndür.
 *
 * @param string $name
 * @param null|string $locale
 *
 * @return mixed
 */
function getEmailTemplate($name, $locale = null) {
    return EmailTemplate::where( 'name', $name )
        ->where( 'locale', ( $locale ?? app()->getLocale() ) )
        ->first();
}

/**
 * E-posta şablon bilgisini döndür.
 *
 * @param int $id
 *
 * @return mixed
 */
function getEmailTemplateById($id) {
    return EmailTemplate::findOrFail( $id );
}

/**
 * E-posta şablon bilgisini döndür.
 *
 * @param string $ref
 *
 * @return mixed
 */
function getEmailTemplateByRef($ref) {
    return EmailTemplate::findByRef( $ref );
}