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
 * Class AbstractModel
 * @package PlusClouds\Core\Database\Models
 */
abstract class AbstractModel extends Model
{

    /**
     * @param string $method
     * @param array $parameters
     *
     * @return mixed
     */
    public function __call($method, $parameters) {
        $class_name = class_basename( $this );

        #i: Convert array to dot notation
        $config = implode( '.', [ 'relation', $class_name, $method ] );

        #i: Relation method resolver
        if( config()->has( $config ) ) {
            $function = config( $config );

            return $function( $this );
        }

        #i: No relation found, return the call to parent (Eloquent) to handle it.
        return parent::__call( $method, $parameters );
    }

}