<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

/**
 * Class AbstractFormRequest
 * @package PlusClouds\Core\Http\Requests
 */
abstract class AbstractFormRequest extends FormRequest
{

    /**
     * @param array $errors
     *
     * @return mixed
     */
    public function response(array $errors) {
        return response()->api()->errorUnprocessable( 'Validation Failed', array_map( function($error) {
            return reset( $error );
        }, array_values( $errors ) ) );
    }

}