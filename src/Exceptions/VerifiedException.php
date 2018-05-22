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

use Throwable;


/**
 * Class VerifiedException
 * @package PlusClouds\Core\Exceptions
 */
class VerifiedException extends AbstractCoreException
{

    /**
     * VerifiedException constructor.
     *
     * @param string $message
     * @param int $code
     * @param Throwable|null $previous
     */
    public function __construct($message = "", $code = 0, Throwable $previous = null) {
        $this->message = $message;
        $this->code = $code;
        $this->previous = $previous;
    }

    /**
     * @param  \Illuminate\Http\Request
     *
     * @return mixed
     */
    public function render($request) {
        return response()->api()->errorBadRequest( $this->getMessage() );
    }

}