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
use Aloha\Twilio\TwilioInterface;
use Services_Twilio_RestException;

/**
 * Class MobilePhone
 * @package PlusClouds\Core\Validation\Rules
 */
class MobilePhone implements Rule
{

    /**
     * @var TwilioInterface
     */
    protected $twilio;

    /**
     * @var
     */
    protected $phoneCode;

    /**
     * MobilePhone constructor.
     *
     * @param TwilioInterface $twilio
     * @param $phoneCode
     */
    public function __construct(TwilioInterface $twilio, $phoneCode) {
        $this->twilio = $twilio;
        $this->phoneCode = $phoneCode;
    }

    /**
     * @param string $attribute
     * @param mixed $value
     *
     * @return bool
     */
    public function passes($attribute, $value) {
        $phone = $this->phoneCode.$value;

        try {
            $this->twilio->getTwilio()
                ->lookups
                ->phoneNumbers( $phone )->fetch( [
                    'type' => 'carrier',
                ] );

            return true;
        }
        catch( Services_Twilio_RestException $e ) {
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