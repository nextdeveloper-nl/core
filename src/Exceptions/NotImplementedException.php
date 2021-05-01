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
class NotImplementedException extends AbstractCoreException
{

    /**
     * @var string
     */
    protected $defaultMessage = 'The function you are trying to reach is not implemented';

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

        return response()->api()->errorNotFound( $message ?: $this->defaultMessage );
    }

}