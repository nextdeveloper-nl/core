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
use Twilio\Exceptions\RestException;

/**
 * Class MobilePhone
 * @package PlusClouds\Core\Validation\Rules
 */
class MobilePhone implements Rule
{

    protected $twilio;

    /**
     * @var int
     */
    protected $phoneCode;

    /**
     * MobilePhone constructor.
     *
     * @param $phoneCode
     */
    public function __construct($phoneCode) {
        $this->twilio = app( 'Twilio' );
        $this->phoneCode = $phoneCode;
    }

    /**
     * @param string $attribute
     * @param mixed $value
     *
     * @return bool
     */
    public function passes($attribute, $value) {
        $phone = '+'.$this->phoneCode.$value;

        try {
            $this->twilio
                ->lookups
                ->phoneNumbers( $phone )->fetch( [
                    'type' => 'carrier',
                ] );

            return true;
        }
        catch( RestException $e ) {
            return false;
        }
    }

    /**
     * @return string
     */
    public function message() {
        return 'The :attribute must be a valid phone number';
    }

}