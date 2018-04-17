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

use Illuminate\Database\Eloquent\SoftDeletes;
use PlusClouds\Core\Database\Observers\DisposableEmailObserver;

/**
 * Class DisposableEmail
 * @package PlusClouds\Core\Database\Models
 */
class DisposableEmail extends AbstractModel
{

    use SoftDeletes;

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
     * @return void
     */
    public static function boot() {
        parent::boot();
        parent::observe( DisposableEmailObserver::class );
    }

    /**
     * @param string $email
     *
     * @return bool
     * @throws \Exception
     */
    public static function check($email) {
        list( , $domain ) = explode( '@', $email );

        if( sizeof( explode( '.', $domain ) ) > 2 ) {
            if( preg_match( config( 'core.disposable_email.regex' ), $domain, $matches ) ) {
                $domain = $matches['domain'];
            }
        }

        $domains = cache()->get( config( 'core.disposable_email.cache.key' ), function() {
            return ( new static )->all();
        } );

        return ! $domains->filter( function($item) use ($domain) {
            return $item->domain == $domain;
        } )->isEmpty();
    }

}