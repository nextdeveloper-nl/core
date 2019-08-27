<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Transformers;


use Illuminate\Support\Str;
use Illuminate\Http\Resources\MergeValue;
use Illuminate\Http\Resources\MissingValue;
use Illuminate\Http\Resources\PotentiallyMissing;
use Illuminate\Support\Traits\Macroable;
use League\Fractal\TransformerAbstract;
use League\Fractal\ParamBag;

/**
 * Class AbstractTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
abstract class AbstractTransformer extends TransformerAbstract
{

    use Macroable;

    /**
     * @var int
     */
    protected $limit;

    /**
     * @var int
     */
    protected $offset;

    /**
     * @var string
     */
    protected $sortKey;

    /**
     * @var int
     */
    protected $sortDirection;

    /**
     * @var array
     */
    protected $fields = [];

    /**
     * @var array
     */
    protected $hidden = [];

    /**
     * @var array
     */
    protected $visible = [];

    /**
     * @var ParamBag
     */
    protected $paramBag;

    /**
     * @var array
     */
    protected $validIncludeParams = [
        'limit'  => [ 3, 0 ], // [limit, offset]
        'sort'   => [ 'created_at', 'desc' ], // [sortKey, sortDirection]
        'fields' => [],
    ];

    /**
     * @return int
     */
    public function getLimit() {
        return $this->limit;
    }

    /**
     * @return int
     */
    public function getOffset() {
        return $this->offset;
    }

    /**
     * @return string
     */
    public function sortKey() {
        return $this->sortKey;
    }

    /**
     * @return int
     */
    public function sortDirection() {
        return $this->sortDirection;
    }

    /**
     * @return array
     */
    public function getFields() {
        return $this->fields;
    }

    /**
     * AbstractTransformer constructor.
     *
     * @param ParamBag|null $paramBag
     *
     * @throws \Exception
     */
    public function __construct(ParamBag $paramBag = null) {
        $this->paramBag = $paramBag;

        if( is_null( $this->paramBag ) ) {
            $this->paramBag = new ParamBag( [] );
        }

        $this->validateIncludeParams();

        $this->setProperties();
    }

    /**
     * @return void
     */
    protected function setProperties() {
        list( $limit, $offset ) = $this->paramBag->get( 'limit' );
        list( $sortKey, $sortDirection ) = $this->paramBag->get( 'sort' );

        $this->limit = $limit ?: $this->limit;
        $this->offset = $offset ?: $this->offset;
        $this->sortKey = $sortKey ?: $this->sortKey;
        $this->sortDirection = $sortDirection ?: $this->sortDirection;

        if( request()->has( 'fields' ) && $this->paramBag->getIterator()->count() == 0 ) {
            $this->fields = explode( ',', request( 'fields' ) );
        } else {
            $this->fields = $this->paramBag->get( 'fields' );
        }
    }

    /**
     * @param $condition
     * @param $value
     * @param null $default
     *
     * @return MissingValue|mixed
     */
    protected function when($condition, $value, $default = null) {
        if( $condition ) {
            return value( $value );
        }

        return func_num_args() === 3 ? value( $default ) : new MissingValue();
    }

    /**
     * @param $condition
     * @param $value
     *
     * @return MergeValue|MissingValue
     */
    protected function mergeWhen($condition, $value) {
        return $condition ? new MergeValue( value( $value ) ) : new MissingValue();
    }

    /**
     * @param $resource
     * @param $relationship
     * @param null $value
     * @param null $default
     *
     * @return MissingValue|mixed|null
     */
    protected function whenLoaded($resource, $relationship, $value = null, $default = null) {
        if( func_num_args() < 4 ) {
            $default = new MissingValue;
        }

        if( ! $resource->relationLoaded( $relationship ) ) {
            return $default;
        }

        if( func_num_args() === 2 ) {
            return $resource->{$relationship};
        }

        if( $resource->{$relationship} === null ) {
            return null;
        }

        return value( $value );
    }

    /**
     * @param $resource
     * @param $table
     * @param $value
     * @param null $default
     *
     * @return \League\Fractal\Resource\NullResource|mixed
     */
    protected function whenPivotLoaded($resource, $table, $value, $default = null) {
        if( func_num_args() === 3 ) {
            $default = new MissingValue();
        }

        $newValue = $value->bindTo( $resource );

        return $this->when(
            $resource->pivot &&
            ( $resource->pivot instanceof $table ||
                $resource->pivot->getTable() === $table ),
            ...[ $newValue, $default ]
        );
    }

    /**
     * @param array $payload
     *
     * @return array
     */
    protected function buildPayload(array $payload) {
        $calledClass = last( explode( '\\', get_called_class() ) );

        collect( $this->fields )->each( function($field, $key) use ($calledClass) {
            if( strpos( $field, '.' ) !== false ) {
                list( $transformer, $field ) = explode( '.', $field );

                $transformer = sprintf( '%sTransformer', Str::studly( $transformer ) );

                if( $transformer !== $calledClass ) {
                    unset( $this->fields[ $key ] );
                } else {
                    $this->fields[ $key ] = $field;
                }
            }
        } );

        if( $visible = $this->visible ) {
            if( $fields = $this->fields ) {
                $visible = array_merge( $visible, $fields );
            }

            $payload = array_only( $payload, $visible );
        }

        if( $hidden = $this->hidden ) {
            if( $fields = $this->fields ) {
                $hidden = array_diff( $this->hidden, $fields );
            }

            $payload = array_except( $payload, $hidden );
        }

        return $this->filter( $payload );
    }

    /**
     * @param $data
     * @param $index
     * @param $merge
     *
     * @return array
     */
    protected function merge($data, $index, $merge) {
        if( array_values( $data ) === $data ) {
            return array_merge(
                array_merge( array_slice( $data, 0, $index, true ), $merge ),
                $this->filter( array_slice( $data, $index + 1, null, true ) )
            );
        }

        return array_slice( $data, 0, $index, true ) +
            $merge +
            $this->filter( array_slice( $data, $index + 1, null, true ) );
    }

    /**
     * @return bool
     * @throws \Exception
     */
    protected function validateIncludeParams() {
        $validParams = array_keys( $this->validIncludeParams );
        $usedParams = array_keys( iterator_to_array( $this->paramBag ) );

        if( $invalidParams = array_diff( $usedParams, $validParams ) ) {
            throw new \Exception(
                sprintf(
                    'Used param(s): "%s". Valid param(s): "%s"',
                    implode( ',', $usedParams ),
                    implode( ',', $validParams )
                )
            );
        }

        $errors = [];

        if( $limit = $this->paramBag->get( 'limit' ) ) {
            if( count( $limit ) !== 2 ) {
                array_push(
                    $errors,
                    'Invalid "limit" value. Valid usage: limit(int|int) where the first int is number of items to retrieve and the second is offset to skip over.'
                );
            }
            foreach( $limit as $item ) {
                if( ! is_numeric( $item ) ) {
                    array_push(
                        $errors,
                        'Invalid "limit" value. Expecting: integer. Given: '.gettype( $item )." \"{$item}\"."
                    );
                }
            }
        }

        if( $sort = $this->paramBag->get( 'sort' ) ) {
            if( count( $sort ) !== 2 ) {
                array_push(
                    $errors,
                    'Invalid "sort" value. Valid usage: sort(string|string) where the first string is attribute name to order by and the second is the sort direction(asc or desc)'
                );
            }

            $allowedSortDirection = [ 'asc', 'desc' ];

            if( isset( $sort[1] ) && ! in_array( strtolower( $sort[1] ), $allowedSortDirection ) ) {
                array_push(
                    $errors,
                    'Invalid "sort" value. Allowed: '.implode( ',', $allowedSortDirection ).". Given: \"{$sort[1]}\""
                );
            }
        }

        if( ! empty( $errors ) ) {
            throw new \Exception( implode( PHP_EOL, $errors ) );
        }

        return true;
    }

    /**
     * @param array $payload
     *
     * @return array
     */
    private function filter(array $payload) {
        $index = -1;

        foreach( $payload as $key => $value ) {
            $index++;

            if( is_array( $value ) ) {
                $data[ $key ] = $this->filter( $value );

                continue;
            }

            if( is_numeric( $key ) && $value instanceof MergeValue ) {
                return $this->merge( $payload, $index, $this->filter( $value->data ) );
            }

            if( ( $value instanceof PotentiallyMissing && $value->isMissing() ) ||
                ( $value instanceof self &&
                    $value instanceof PotentiallyMissing &&
                    $value->isMissing() ) ) {

                unset( $payload[ $key ] );

                $index--;
            }

            if( $value instanceof self && is_null( $value ) ) {
                $data[ $key ] = null;
            }
        }

        return $payload;
    }

}