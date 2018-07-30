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
     * @return mixed
     */
    public function history() {
        return $this->morphMany( History::class, 'historyable' );
    }

    /**
     * @return void
     */
    public static function bootHistoryable() {
        static::updating( function($model) {
            $model->track( $model );
        } );
    }

    /**
     * @param Model $model
     */
    protected function track(Model $model) {
        $chain = new Blakechain();

        $model->history->each( function($item) use ($chain) {
            $chain->appendData( $item->body );
        } );

        $data = json_encode( [
            'old' => collect( $model->getOriginal() )->only( $this->logColumns )->toArray(),
            'new' => collect( $model->toArray() )->only( $this->logColumns )->toArray(),
        ] );

        $chain->appendData( $data );

        $model->history()->create( [
            'historyable_id'   => $model->id,
            'historyable_type' => get_class( $model ),
            'user_id'          => getAUUser()->id,
            'body'             => $data,
            'hash'             => $chain->getLastHash(),
        ] );
    }

    /**
     * @return bool
     */
    public function verifyHistory() {
        $realChain = new Blakechain();
        $lastChain = new Blakechain();

        // Geçmiş verisini alıp zinir olarak yüklüyoruz ve hash değerlerini oluşturuyoruz.
        ( $histories = $this->history )
            ->each( function($item) use ($realChain) {
                $realChain->appendData( $item->body );
            } );

        // DB'de kayıtlı gerçek veriyi işleyip formatlıyoruz.
        $lastData = array_merge(
            json_decode( $histories->last()->body, true ),
            [
                'new' => $this->only( $this->logColumns ),
            ]
        );


        // Geçmiş kayıtlarından son veriyi çıkarıp, DB'de bulunan orjinal veriyi zincire atıp
        // hash değerlerini oluşturuyoruz.
        $histories->splice( 0, -1 )
            ->each( function($item) use ($lastChain) {
                $lastChain->appendData( $item->body );
            } );

        $lastChain->appendData( json_encode( $lastData ) );

        // Geçmiş verisi ile DB datasını karşılaştırıyoruz.
        return ( new Verifier() )
            ->verifyLastHash( $lastChain, $realChain->getLastHash() );
    }

}