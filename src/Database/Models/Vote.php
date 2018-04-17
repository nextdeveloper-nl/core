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

use Illuminate\Support\Carbon;

/**
 * Class Vote
 * @package PlusClouds\Core\Database\Models
 */
class Vote extends AbstractModel
{

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @var array
     */
    protected $dates = [
        'deleted_at',
    ];

    /**
     * @param $value
     */
    public function setValueAttribute($value) {
        $this->attributes['value'] = ( $value == -1 ) ? -1 : 1;
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphTo
     */
    public function voteable() {
        return $this->morphTo();
    }

    /**
     * @param $voteable
     * @param $voter
     *
     * @return mixed
     */
    public function isVotedByUser($voteable, $voter) {
        return $voteable->votes()->where( 'voter', (
            is_a( $voter, 'PlusClouds\Account\Database\Models\User' )
                ? $voter->id
                : $voter
        ) )->exists();
    }

    /**
     * Tüm oyların toplamını verir.
     *
     * @param $voteable
     *
     * @return mixed
     */
    public static function sum($voteable) {
        return $voteable->votes()->sum( 'value' );
    }

    /**
     * Tüm oyların sayısını verir.
     *
     * @param $voteable
     *
     * @return mixed
     */
    public static function count($voteable) {
        return $voteable->votes()->count();
    }

    /**
     * Tüm olumlu oyların sayısını verir.
     *
     * @param $voteable
     * @param int $value
     *
     * @return mixed
     */
    public static function countUps($voteable, $value = 1) {
        return $voteable->votes()->where( 'value', $value )->count();
    }

    /**
     * Tüm olumsuz oyların sayısını verir.
     *
     * @param $voteable
     * @param int $value
     *
     * @return mixed
     */
    public static function countDowns($voteable, $value = -1) {
        return $voteable->votes()->where( 'value', $value )->count();
    }

    /**
     * İki tarih arasındaki oyların sayısını verir.
     *
     * @param $voteable
     * @param $from
     * @param null $to
     *
     * @return mixed
     */
    public static function countByDate($voteable, $from, $to = null) {
        if( ! empty( $to ) ) {
            $range = [ new Carbon( $from ), new Carbon( $to ) ];
        } else {
            $range = [
                ( new Carbon( $from ) )->startOfDay(),
                ( new Carbon( $to ) )->endOfDay(),
            ];
        }

        return $voteable->votes()->whereBetween( 'created_at', $range )->count();
    }

    /**
     * Olumlu oy kullandırır.
     *
     * @param $voteable
     * @param $voter
     *
     * @return bool
     */
    public static function up($voteable, $voter) {
        return (bool) static::cast( $voteable,
            ( is_a( $voter, 'PlusClouds\Account\Database\Models\User' )
                ? $voter->id
                : $voter
            ), 1 );
    }

    /**
     * Olumsuz oy kullandırır.
     *
     * @param $voteable
     * @param $voter
     *
     * @return bool
     */
    public static function down($voteable, $voter) {
        return (bool) static::cast( $voteable,
            ( is_a( $voter, 'PlusClouds\Account\Database\Models\User' )
                ? $voter->id
                : $voter
            ), -1 );
    }

    /**
     * @param $voteable
     * @param $voter
     * @param int $value
     *
     * @return bool
     */
    protected static function cast($voteable, $voter, $value = 1) {
        if( ( new static() )->isVotedByUser( $voteable, $voter ) ) {
            return false;
        }

        $vote = new static();
        $vote->voter = $voter;
        $vote->value = $value;

        return (bool) $vote->voteable()->associate( $voteable )->save();
    }

}