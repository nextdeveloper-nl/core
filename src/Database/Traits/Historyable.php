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


use Illuminate\Database\Eloquent\Model;
use ParagonIE\Blakechain\Blakechain;
use ParagonIE\Blakechain\Verifier;
use PlusClouds\Core\Database\Models\History;

/**
 * Trait Historyable
 * @package PlusClouds\Core\Database\Traits
 */
trait Historyable
{

    /**
     * @var bool
     */
    protected $enableHistory = true;

    /**
     * @return mixed
     */
    public function history() {
        $historyModel = isset( $this->history_model ) ? $this->history_model : History::class;

        return $this->morphMany( $historyModel, 'historyable' );
    }

    /**
     * @return void
     */
    public static function bootHistoryable() {
        static::created( function(Model $model) {
            if( $model->shouldHistoryEvent() ) {
                $model->track( $model, true );
            }
        } );

        static::updating( function(Model $model) {
            if( $model->shouldHistoryEvent() ) {
                $model->track( $model );
            }
        } );

        static::deleting( function(Model $model) {
            if( $model->shouldHistoryEvent() ) {
                $model->track( $model, true );
            }
        } );
    }

    /**
     * @return $this
     */
    public function disableHistory() {
        $this->enableHistory = false;

        return $this;
    }

    /**
     * @return $this
     */
    public function enableHistory() {
        $this->enableHistory = true;

        return $this;
    }

    /**
     * @return bool
     */
    protected function shouldHistoryEvent() {
        return $this->enableHistory;
    }

    /**
     * @param Model $model
     * @param bool $force
     *
     * @return bool
     * @throws \SodiumException
     */
    protected function track(Model $model, $force = false) {
        $excludeHistoryableColumns = array_merge(
            [ $model->getKeyName(), 'id_ref' ],
            ( $this->excludeHistoryableColumns ?? [] ),
            ( $model->getDates() ?? [] )
        );

        if( ! $force ) {
            // Eğer değişen sütunlar ve harici sütünlar birbirine eşit ise,
            // herhangi bir izleme işlemi yapılmayacak
            if( collect( $model->getDirty() )->keys()->diff( $excludeHistoryableColumns )->isEmpty() ) {
                return false;
            }
        }

        // Veriler içerisinden harici tutulan alanları kaldırıyoruz.
        $data = collect( $model->getOriginal() )
            ->merge( $model->getDirty() )
            ->except( $excludeHistoryableColumns )
            ->toArray();

        ksort( $data );

        $chain = new Blakechain();

        if( ! is_null( $last = $model->history->last() ) ) {
            $chain->appendData( crc32( json_encode( $last->body, JSON_NUMERIC_CHECK ) ) );
        }

        $chain->appendData( crc32( json_encode( $data, JSON_NUMERIC_CHECK ) ) );

        $model->history()->create( [
            'historyable_id'   => $model->id,
            'historyable_type' => get_class( $model ),
            'user_id'          => $this->getCurrentUser(),
            'body'             => $data,
            'hash'             => $chain->getLastHash(),
        ] );

        return true;
    }

    /**
     * @return bool
     * @throws \SodiumException
     */
    public function verifyHistory() {
        if( $this->history->isEmpty() ) {
            return false;
        }

        $excludeHistoryableColumns = array_merge(
            [ $this->getKeyName(), 'id_ref' ],
            ( $this->excludeHistoryableColumns ?? [] ),
            ( $this->getDates() ?? [] )
        );

        $realChain = new Blakechain();
        $lastChain = new Blakechain();

        $data = collect( $this->getOriginal() )
            ->except( $excludeHistoryableColumns )
            ->toArray();

        ksort( $data );

        $history = $this->history()->orderBy( 'id', 'DESC' )->skip( 1 )->first();

        $lastChain->appendData( crc32( json_encode( $history->body, JSON_NUMERIC_CHECK ) ) );
        $lastChain->appendData( crc32( json_encode( $data, JSON_NUMERIC_CHECK ) ) );

        $histories = $this->history()->orderBy( 'id', 'DESC' )->take( 2 )->get();

        $histories->sortBy( 'id' )
            ->each( function($history) use ($realChain) {
                $realChain->appendData( crc32( json_encode( $history->body, JSON_NUMERIC_CHECK ) ) );
            } );

        // Geçmiş verisi ile DB datasını karşılaştırıyoruz.
        return ( new Verifier() )
            ->verifyLastHash( $lastChain, $realChain->getLastHash() );
    }

    /**
     * @param string $hash
     *
     * @return bool
     */
    public function revertTo($hash) {
        $history = $this->history()->where( 'hash', $hash )->first();

        if( ! is_null( $history ) ) {
            $this->forceFill( $history->body );

            return $this->save();
        }

        return false;
    }

    /**
     * @return null|int
     */
    private function getCurrentUser() {
        return isLoggedIn() ? getAUUser()->id : null;
    }

}