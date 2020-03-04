<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Exceptions;


/**
 * Class ConflictException
 * @package PlusClouds\Core\Exceptions
 */
class ConflictException extends AbstractCoreException
{

    /**
     * @var string
     */
    protected $defaultMessage = 'Related records are included in your data';

    /**
     * @param \Illuminate\Http\Request
     *
     * @return mixed
     */
    public function render($request) {
        $message = $this->getMessage();

        if( str_contains( $message, $this->defaultMessage ) ) {
            $message = null;
        }


        return response()->api()->errorConflict( $message ?: $this->defaultMessage );
    }

}