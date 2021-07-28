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

use PlusClouds\Core\Exceptions\InvalidColumnNameException;

class ColumnNameSanitizer {
    /**
     * Based on maximum column name length.
     */
    public const MAX_COLUMN_NAME_LENGTH = 64;

    /**
     * Column names are alphanumeric strings that can contain
     * underscores (`_`) but can't start with a number.
     */
    private const VALID_COLUMN_NAME_REGEX = '/^(?![0-9])[A-Za-z0-9_-]*$/';

    public static function sanitize(string $column) : string {
        if (strlen($column) > self::MAX_COLUMN_NAME_LENGTH) {
            throw InvalidColumnNameException::columnNameTooLong($column, self::MAX_COLUMN_NAME_LENGTH);
        }

        if ( ! preg_match(self::VALID_COLUMN_NAME_REGEX, $column)) {
            throw InvalidColumnNameException::invalidCharacters($column);
        }

        return $column;
    }

    public static function sanitizeArray(array $columns) : array {
        return array_map([self::class, 'sanitize'], $columns);
    }
}
