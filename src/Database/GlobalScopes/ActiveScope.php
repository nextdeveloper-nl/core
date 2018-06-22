<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\GlobalScopes;

use Illuminate\Database\Eloquent\Scope;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;

/**
 * Class ActiveScope
 * @package PlusClouds\Core\Database\GlobalScopes
 */
class ActiveScope implements Scope
{

    /**
     * @param Builder $builder
     * @param Model $model
     */
    public function apply(Builder $builder, Model $model) {
        $column = $model->getTable().'.is_active';

        $builder->where( $column, true );
    }

    /**
     * @param Builder $builder
     */
    public function extend(Builder $builder) {
        $builder->macro( 'withPassive', function(Builder $builder) {
            return $builder->withoutGlobalScope( $this );
        } );
    }


}