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
 * Class LocaleScope
 * @package PlusClouds\Core\Database\GlobalScopes
 */
class LocaleScope implements Scope
{

    /**
     * @param Builder $builder
     * @param Model $model
     */
    public function apply(Builder $builder, Model $model) {
        $relationTable = ( $relation = $model->translations() )->getRelated()->getTable();

        $builder->leftJoin( $relationTable, $relation->getQualifiedForeignKeyName(), $model->getQualifiedKeyName() )
            ->whereNull( sprintf( '%s.locale', $relationTable ) )
            ->orWhere( sprintf( '%s.locale', $relationTable ), app()->getLocale() )
            ->select( sprintf( '%s.*', $model->getTable() ) );
    }

    /**
     * @param Builder $builder
     */
    public function extend(Builder $builder) {
        $builder->macro( 'withLocale', function(Builder $builder) {
            return $builder->withoutGlobalScope( $this );
        } );
    }

}