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
 * Class ValidationException.
 *
 * @package PlusClouds\Core\Exceptions
 */
class ValidationException extends AbstractCoreException {
    /**
     * @param  \Illuminate\Http\Request
     * @param mixed $request
     *
     * @return mixed
     */
    public function render($request) {
        return $request->expectsJson()
                    ? response()->api()->errorUnprocessable(optional($this->originalException)->errors() ?? $this->getMessage())
                    : redirect()->guest(route('login', ['locale' => app()->getLocale()]))->withErrors(optional($this->originalException)->errors() ?? $this->getMessage());
    }
}
