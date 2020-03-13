<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;


use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Database\Query\Builder as QueryBuilder;
use Illuminate\Support\Facades\DB;
use PlusClouds\Core\Events\StateUpdated;
use PlusClouds\Core\Exceptions\InvalidState;

/**
 * Trait HasStates
 * @package PlusClouds\Core\Database\Traits
 */
trait HasStates
{

    /**
     * @var bool
     */
    protected $overwriteState = false;

    /**
     * @param bool $overwrite
     *
     * @return $this
     */
    public function setOverwriteState($overwrite) {
        $this->overwriteState = (bool) $overwrite;

        return $this;
    }

    /**
     * @return mixed
     */
    public function states() {
        return $this->morphMany(
            $this->getStateModelClassName(), 'model', 'model_type', $this->getModelKeyColumnName()
        )->latest( 'id' );
    }

    /**
     * @return mixed
     */
    public function state() {
        return $this->latestState();
    }

    /**
     * @param $name
     * @param null $value
     * @param null $reason
     * @param bool $overwrite
     *
     * @return HasStates
     * @throws InvalidState
     */
    public function setState($name, $value = null, $reason = null, $overwrite = false) {
        if( ! $this->isValidState( $name ) ) {
            throw InvalidState::create( $name );
        }

        return $this->forceSetState( $name, $value, $reason, $overwrite );
    }

    /**
     * @param $name
     * @param null $value
     * @param null $reason
     *
     * @return bool
     */
    public function isValidState($name, $value = null, $reason = null) {
        return true;
    }

    /**
     * @param null $names
     *
     * @return mixed
     */
    public function latestState($names = null) {
        $states = $this->relationLoaded( 'states' ) ? $this->states : $this->states();

        $names = is_array( $names ) ? array_flatten( $names ) : func_get_args();

        if( ! count( $names ) ) {
            return $states->first();
        }

        return $states->whereIn( 'name', $names )->first();
    }

    /**
     * @param $name
     *
     * @return bool
     */
    public function hasEverHadState($name) {
        $states = $this->relationLoaded( 'states' ) ? $this->states : $this->states();

        return $states->where( 'name', $name )->count() > 0;
    }

    /**
     * @param null $names
     *
     * @return $this
     */
    public function deleteState($names = null) {
        $names = is_array( $names ) ? array_flatten( $names ) : func_get_args();

        if( ! count( $names ) ) {
            return $this;
        }

        $this->states()->whereIn( 'name', $names )->delete();
    }

    /**
     * @param Builder $builder
     * @param array|string $names
     */
    public function scopeCurrentState(Builder $builder, $names = []) {
        $names = is_array( $names ) ? array_flatten( $names ) : func_get_args();

        array_shift( $names );

        $builder
            ->whereHas(
                'states',
                function($query) use ($names) {
                    $query
                        ->whereIn( 'name', $names )
                        ->whereIn(
                            'id',
                            function(QueryBuilder $query) {
                                $query
                                    ->select( DB::raw( 'max(id)' ) )
                                    ->from( $this->getStateTableName() )
                                    ->where( 'model_type', $this->getStateModelType() )
                                    ->whereColumn( $this->getModelKeyColumnName(), $this->getQualifiedKeyName() );
                            }
                        );
                }
            );
    }

    /**
     * @param Builder $builder
     * @param array|string $names
     */
    public function scopeOtherCurrentState(Builder $builder, $names = []) {
        $names = is_array( $names ) ? array_flatten( $names ) : func_get_args();

        array_shift( $names );

        $builder
            ->whereHas(
                'states',
                function(Builder $query) use ($names) {
                    $query
                        ->whereNotIn( 'name', $names )
                        ->whereIn(
                            'id',
                            function(QueryBuilder $query) use ($names) {
                                $query
                                    ->select( DB::raw( 'max(id)' ) )
                                    ->from( $this->getStateTableName() )
                                    ->where( 'model_type', $this->getStateModelType() )
                                    ->whereColumn( $this->getModelKeyColumnName(), $this->getQualifiedKeyName() );
                            }
                        );
                }
            )
            ->orWhereDoesntHave( 'states' );
    }

    /**
     * @return string
     */
    public function getStateAttribute() {
        return (string) $this->latestState();
    }

    /**
     * @param $name
     * @param null $value
     * @param null $reason
     * @param bool $overwrite
     *
     * @return $this
     */
    public function forceSetState($name, $value = null, $reason = null, $overwrite = false) {
        if( $overwrite !== false ) {
            $this->setOverwriteState( $overwrite );
        }

        $newState = null;
        $updated = false;

        $latestState = $this->latestState( $name );

        if( $this->overwriteState ) {
            if( is_null( $latestState ) ) {
                goto firstRecord;
            }

            $latestState->update( [
                'value'  => $value,
                'reason' => $reason,
            ] );

            $updated = true;
        } else {
            if( ! is_null( $value ) ) {
                if( ! is_null( $latestState ) ) {
                    if( $latestState->value == $value ) {
                        return $this;
                    }
                }
            }

            firstRecord :
            $newState = $this->states()->create( [
                'name'   => $name,
                'value'  => $value,
                'reason' => $reason,
            ] );

            $updated = true;
        }

        if( $updated ) {
            event( new StateUpdated( $latestState, ( $newState ?? $latestState->fresh() ), $this ) );
        }

        return $this;
    }

    /**
     * @return mixed
     */
    protected function getStateTableName() {
        $modelClass = $this->getStateModelClassName();

        return ( new $modelClass )->getTable();
    }

    /**
     * @return string
     */
    protected function getModelKeyColumnName() {
        return 'model_id';
    }

    /**
     * @return string
     */
    protected function getStateModelClassName() {
        return \PlusClouds\Core\Database\Models\State::class;
    }

    /**
     * @return string
     */
    protected function getStateModelType() {
        return array_search( static::class, Relation::morphMap() ) ?: static::class;
    }
}