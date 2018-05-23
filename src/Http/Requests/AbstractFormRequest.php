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

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Validation\ValidationException;

/**
 * Class AbstractFormRequest
 * @package PlusClouds\Core\Http\Requests
 */
abstract class AbstractFormRequest extends FormRequest
{

    /**
     * @param Validator $validator
     */
    protected function failedValidation(Validator $validator) {
        $errors = ( new ValidationException( $validator ) )->errors();

        throw new HttpResponseException( response()->api()->errorUnprocessable( 'Validation Failed', $errors ) );
    }

}