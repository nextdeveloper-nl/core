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

use Illuminate\Http\Response;

/**
 * Class InvalidColumnNameException.
 *
 * @package PlusClouds\Core\Exceptions
 */
class InitiatorNotExistsException extends AbstractCoreException {
    /**
     * @var string
     */
    public $column;

    public function __construct() {
    }

    /**
     * @param  \Illuminate\Http\Request
     * @param mixed $request
     *
     * @return mixed
     */
    public function render($request) {
        return response()->api()->errorBadRequest($this->getMessage());
    }
}
