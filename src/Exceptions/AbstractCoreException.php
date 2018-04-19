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
 * Class AbstractCoreException
 * @package PlusClouds\Core\Exceptions
 */
abstract class AbstractCoreException extends Exception
{

    /**
     * @var int|null|string
     */
    protected $ref;

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
     * AbstractCoreException constructor.
     *
     * @param Exception $e
     * @param null|string|int $ref
     */
    public function __construct(Exception $e, $ref = null ) {
        $this->ref = $ref;
        $this->code = $e->getCode();
        $this->message = $e->getMessage();
        $this->file = $e->getFile();
        $this->line = $e->getLine();
        $this->trace = $e->getTrace();
    }

    /**
     * @return int|null|string
     */
    public function getRef(){
        return $this->ref;
    }

}