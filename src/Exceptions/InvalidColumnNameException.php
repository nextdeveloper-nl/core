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
class InvalidColumnNameException extends AbstractCoreException {
    /**
     * @var string
     */
    public $column;

    public function __construct(string $column, string $message) {
        $this->column = $column;

        parent::__construct($message);
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

    /**
     * @param string $column
     * @param int    $maxLength
     *
     * @return void
     */
    public static function columnNameTooLong($column, $maxLength = 64) {
        return new static($column, "Given column name `{$column}` exceeds the maximum column name length of {$maxLength} characters.");
    }

    /**
     * @param string $column
     *
     * @return void
     */
    public static function invalidCharacters($column) {
        return new static($column, 'Column name may contain only alphanumerics or underscores, and may not begin with a digit.');
    }
}
