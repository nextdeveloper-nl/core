<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Helpers;


/**
 * Class PasswordComplexity
 * @package PlusClouds\Core\Helpers
 */
final class PasswordComplexity
{

    /**
     * @var int
     */
    protected $minPasswordLength = 8;

    /**
     * @var int
     */
    protected $baseScore = 0;

    /**
     * @var int
     */
    protected $score = 0;

    /**
     * @var array
     */
    private $sizes = [
        'excess'  => 0,
        'upper'   => 0,
        'numbers' => 0,
        'symbols' => 0,
    ];

    /**
     * @var array
     */
    private $bonus = [
        'excess'     => 3,
        'upper'      => 4,
        'numbers'    => 5,
        'symbols'    => 5,
        'combo'      => 0,
        'flatLower'  => 0,
        'flatNumber' => 0,
    ];

    /**
     * @param $password
     *
     * @return mixed
     */
    public function check($password) {
        if( strlen( $password ) >= $this->minPasswordLength ) {
            $this->baseScore = 50;
            $this->analyze( $password );
            $this->complexity();
        } else {
            $this->baseScore = 0;
        }

        return $this->output( $password );
    }

    /**
     * @param $password
     *
     * @return string
     */
    private function output($password) {
        if( strlen( $password ) < $this->minPasswordLength ) {
            return sprintf( 'At least %d characters please!', $this->minPasswordLength );
        } elseif( $this->score < 50 ) {
            return 'Week';
        } elseif( ( $this->score >= 50 && $this->score < 75 ) ) {
            return 'Average!';
        } elseif( ( $this->score >= 75 && $this->score < 100 ) ) {
            return 'Strong!';
        } elseif( $this->score >= 100 ) {
            return 'Secure!';
        }
    }

    /**
     * @param $password
     */
    private function analyze($password) {
        $passwordLength = strlen( $password );

        for( $i = 0; $i < $passwordLength; $i++ ) {
            if( preg_match( '#[A-Z]+#', $password[ $i ] ) ) {
                $this->sizes['upper']++;
            }

            if( preg_match( '#[0-9]+#', $password[ $i ] ) ) {
                $this->sizes['numbers']++;
            }

            if( preg_match( '#\W+#', $password[ $i ] ) ) {
                $this->sizes['symbols']++;
            }
        }

        $this->sizes['excess'] = $passwordLength - $this->minPasswordLength;

        if( $this->sizes['numbers'] && $this->sizes['upper'] && $this->sizes['symbols'] ) {
            $this->bonus['combo'] = 25;
        } elseif(
            ( $this->sizes['numbers'] || $this->sizes['upper'] )
            || ( $this->sizes['symbols'] || $this->sizes['upper'] )
            || ( $this->sizes['numbers'] || $this->sizes['symbols'] )
        ) {
            $this->bonus['combo'] = 15;
        }

        if( preg_match( '#[\sa-z]#', $password ) ) {
            $this->bonus['flatLower'] = -15;
        }

        if( preg_match( '#[\s0-9]#', $password ) ) {
            $this->bonus['flatNumber'] = -15;
        }
    }

    /**
     * @return void
     */
    private function complexity() {
        $this->score = $this->baseScore
            + ( $this->sizes['excess'] * $this->bonus['excess'] )
            + ( $this->sizes['upper'] * $this->bonus['upper'] )
            + ( $this->sizes['symbols'] * $this->bonus['symbols'] )
            + $this->bonus['combo']
            + $this->bonus['flatLower']
            + $this->bonus['flatNumber'];
    }

}