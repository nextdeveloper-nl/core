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

use Exception;

/**
 * Class AbstractCoreException.
 *
 * @package PlusClouds\Core\Exceptions
 */
abstract class AbstractCoreException extends Exception implements ICoreException {
    /**
     * @var int|mixed
     */
    protected $code;

    /**
     * @var string
     */
    protected $message;

    /**
     * @var string
     */
    protected $file;

    /**
     * @var int
     */
    protected $line;

    /**
     * @var array
     */
    protected $trace;

    /**
     * @var Exception
     */
    protected $originalException;

    /**
     * AbstractCoreException constructor.
     */
    public function __construct() {
        $args = func_get_args();

        if (($e = array_get($args, 0)) instanceof \Throwable) {
            $this->originalException = $e;

            $this->code = $e->getCode();
            $this->message = $e->getMessage();
            $this->file = $e->getFile();
            $this->line = $e->getLine();
            $this->trace = $e->getTrace();
        } else {
            $this->message = array_get($args, 0);
            $this->code = array_get($args, 1);
            $this->previous = array_get($args, 2);
        }
    }
}
