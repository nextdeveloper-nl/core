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
    }

    /**
     * @return $this
     */
    public function disableHistory() {
        $this->enableHistory = false;

        return $this;
    }

    /**
     * @return bool
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

        $chain = new Blakechain();

        $model->history->each( function($item) use ($model, $chain) {
            $chain->appendData( json_encode( $item->body, JSON_NUMERIC_CHECK ) );
        } );

        $chain->appendData( json_encode( $data, JSON_NUMERIC_CHECK ) );

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

        // Geçmiş verisini alıp zincir olarak yüklüyoruz ve hash değerlerini oluşturuyoruz.
        ( $histories = $this->history )
            ->each( function($item) use ($realChain) {
                $realChain->appendData( json_encode( $item->body, JSON_NUMERIC_CHECK ) );
            } );

        $data = collect( $this->getOriginal() )
            ->except( $excludeHistoryableColumns )
            ->toArray();

        // Geçmiş kayıtlarından son veriyi çıkarıp, DB'de bulunan orjinal veriyi zincire atıp
        // hash değerlerini oluşturuyoruz.
        $histories->splice( 0, -1 )
            ->each( function($item) use ($lastChain) {
                $lastChain->appendData( json_encode( $item->body, JSON_NUMERIC_CHECK ) );
            } );

        $lastChain->appendData( json_encode( $data, JSON_NUMERIC_CHECK ) );

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
        $history = $this->history->filter( function($item) use ($hash) {
            return $item->hash === $hash;
        } )->first();

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