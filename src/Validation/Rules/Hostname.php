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
use Zend\Validator\Hostname as ZendHostname;

/**
 * Class Hostname
 * @package PlusClouds\Core\Validation\Rules
 */
class Hostname implements Rule
{

    /**
     * @param string $attribute
     * @param mixed $value
     *
     * @return bool
     */
    public function passes($attribute, $value) {
        $validator = new ZendHostname( [
            'allow'       => ZendHostname::ALLOW_DNS,
            'useIdnCheck' => true,
            'useTldCheck' => false,
        ] );

        return $validator->isValid( $value );
    }

    /**
     * @return string
     */
    public function message() {
        return 'The :attribute must be a valid domain name';
    }


}