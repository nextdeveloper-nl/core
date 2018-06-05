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

/**
 * Class CreditCard
 * @package PlusClouds\Core\Validation\Rules
 */
class CreditCard implements Rule
{

    /**
     * @var array
     */
    private $cards = [
        'default'           => [ 'length' => '13,14,15,16,17,18,19', 'prefix' => '', 'luhn' => true, ],
        'american_expiress' => [ 'length' => '15', 'prefix' => '3[47]', 'luhn' => true, ],
        'diners_club'       => [ 'length' => '14,16', 'prefix' => '36|55|30[0-5]', 'luhn' => true, ],
        'discover'          => [ 'length' => '16', 'prefix' => '6(?:5|011)', 'luhn' => true, ],
        'jcb'               => [ 'length' => '15,16', 'prefix' => '3|1800|2131', 'luhn' => true, ],
        'maestro'           => [ 'length' => '16,18', 'prefix' => '50(?:20|38)|6(?:304|759)', 'luhn' => true, ],
        'mastercard'        => [ 'length' => '16', 'prefix' => '5[1-5]', 'luhn' => true, ],
        'visa'              => [ 'length' => '13,16', 'prefix' => '4', 'luhn' => true, ],
    ];

    /**
     * @var string
     */
    protected $type;

    /**
     * CreditCard constructor.
     *
     * @param string $type
     */
    public function __construct($type = 'default') {
        $this->type = $type;
    }

    /**
     * @param string $attribute
     * @param mixed $value
     *
     * @return bool
     */
    public function passes($attribute, $value) {
        // Remove all non-digit characters from the number
        if( ( $number = preg_replace( '/\D+/', '', $value ) ) === '' ) {
            return false;
        }

        // Check card type
        $type = strtolower( $this->type );

        if( ! isset( $this->cards[ $type ] ) ) {
            return false;
        }

        // Check card number length
        $length = strlen( $number );

        // Validate the card length by the card type
        if( ! in_array( $length, preg_split( '/\D+/', $this->cards[ $type ]['length'] ) ) ) {
            return false;
        }

        // Check card number prefix
        if( ! preg_match( '/^'.$this->cards[ $type ]['prefix'].'/', $number ) ) {
            return false;
        }

        if( $this->cards[ $type ]['luhn'] == false ) {
            return true;
        }

        return $this->luhn( $value );
    }

    /**
     * @return string
     */
    public function message() {
        return 'The :attribute must be a valid credit card number';
    }

    /**
     * @param $number
     *
     * @return bool
     */
    private function luhn($number) {
        // Force the value to be a string as this method uses string functions.
        // Converting to an integer may pass PHP_INT_MAX and result in an error!
        $number = (string) $number;

        if( ! ctype_digit( $number ) ) {
            // Luhn can only be used on numbers!
            return false;
        }

        // Check number length
        $length = strlen( $number );

        // Checksum of the card number
        $checksum = 0;

        for( $i = $length - 1; $i >= 0; $i -= 2 ) {
            // Add up every 2nd digit, starting from the right
            $checksum += substr( $number, $i, 1 );
        }

        for( $i = $length - 2; $i >= 0; $i -= 2 ) {
            // Add up every 2nd digit doubled, starting from the right
            $double = substr( $number, $i, 1 ) * 2;

            // Subtract 9 from the double where value is greater than 10
            $checksum += ( $double >= 10 ) ? ( $double - 9 ) : $double;
        }

        // If the checksum is a multiple of 10, the number is valid
        return ( $checksum % 10 === 0 );
    }


}