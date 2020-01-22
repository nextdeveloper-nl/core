<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Filters;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Traits\Macroable;
use PlusClouds\Core\Database\GlobalScopes\OrderScope;

/**
 * Class AbstractQueryFilter
 * @package PlusClouds\Core\Database\Filters
 */
abstract class AbstractQueryFilter
{

    use Macroable;

    /**
     * @var Request
     */
    protected $request;

    /**
     * @var Builder
     */
    protected $builder;

    /**
     * QueryFilter constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request) {
        $this->request = $request;
    }

    /**
     * @param Builder $builder
     *
     * @return Builder
     * @throws \ReflectionException
     */
    public function apply(Builder $builder) {
        $this->builder = $builder;

        foreach( $this->filters() as $name => $value ) {
            $name = camel_case( $name );

            if( method_exists( $this, $name ) && $this->checkFilterRules( $name ) ) {
                $r = new \ReflectionMethod( $this, $name );
                $s = count( $r->getParameters() );

                // "?param" ve "?param=" kontrolü
                if( $s == 0 || ( $s > 0 && ! is_null( $value ) ) ) {
                    call_user_func_array( [ $this, $name ], array_filter( [ $value ], function($v) {
                        return isset( $v );
                    } ) );
                }
            }
        }

        return $this->builder;
    }

    /**
     * @return array
     */
    public function filters() {
        return $this->request->all();
    }

    /**
     * @param string $value
     *
     * @return Builder
     */
    protected function position($value) {
        $this->builder->getQuery()->orders = [];

        $value = explode( ',', $value );

        foreach( $value as $item ) {
            if( str_contains( $item, '|' ) ) {
                list( $column, $direction ) = explode( '|', $item );
            } else {
                $column = $item;
                $direction = 'ASC';
            }

            $this->builder->withoutGlobalScope( OrderScope::class )
                ->orderBy( $column, $direction );
        }

        return $this->builder;
    }

    /**
     * @param string $filterName
     *
     * @return bool
     */
    private function checkFilterRules($filterName) {
        $results = [];

        if( method_exists( $this, 'filterRules' ) ) {
            $rules = $this->filterRules();

            if( isset( $rules[ $filterName ] ) ) {
                if( ! is_array( $rules[ $filterName ] ) ) {
                    $rules[ $filterName ] = (array) $rules[ $filterName ];
                }

                foreach( $rules[ $filterName ] as $filter ) {
                    if( is_callable( $filter ) ) {
                        $results[] = $filter();
                    } else {
                        if( str_contains( $filter, ':' ) ) {
                            list( $func, $args ) = explode( ':', $filter );

                            $results[] = call_user_func_array( [ $this, $func ], explode( ',', $args ) );
                        } else {
                            $results[] = call_user_func( [ $this, $filter ] );
                        }
                    }
                }
            }
        }

        return ! collect( $results )->contains( false );
    }

}