<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class AbstractModel.
 *
 * @package PlusClouds\Core\Database\Models
 */
abstract class AbstractModel extends Model {
    /**
     * @var int
     */
    protected $perPage = 16;

    /**
     * @param string $method
     * @param array  $parameters
     *
     * @return mixed
     */
    public function __call($method, $parameters) {
        $class_name = class_basename($this);

        //i: Convert array to dot notation
        $config = implode('.', ['relation', strtolower($class_name), $method]);

        //i: Relation method resolver
        if (config()->has($config)) {
            $relation = config($config);

            return $relation($this);
        }



        //i: No relation found, return the call to parent (Eloquent) to handle it.
        return parent::__call($method, $parameters);
    }

    /**
     * @param string $key
     *
     * @return mixed
     */
    public function __get($key) {
        $class_name = class_basename($this);

        //i: Convert array to dot notation
        $config = implode('.', ['relation', strtolower($class_name), $key]);

        //i: Relation method resolver
        if (config()->has($config)) {
            if ( ! property_exists($this, $key)) {
                $relation = config($config);

                return tap($relation($this)->getResults(), function ($results) use ($key) {
                    $this->setRelation($key, $results);
                });
            }
        }

        return parent::__get($key);
    }

    /**
     * @param string $column
     *
     * @return array
     */
    public static function getPossibleEnumValues($column) {
        // Create an instance of the model to be able to get the table name
        $instance = new static();

        // Pulls column string from DB
        $enum = \DB::select(\DB::raw('SHOW COLUMNS FROM '.$instance->getTable().' WHERE Field = "'.$column.'"'))[0]->Type;

        // Parse string
        preg_match_all("/'([^']+)'/", $enum, $matches);

        // Return matches
        return $matches[1] ?? [];
    }
}
