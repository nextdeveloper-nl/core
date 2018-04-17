<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Middleware;

use Closure;

/**
 * Class ETag
 * @package PlusClouds\Core\Http\Middleware
 */
class ETag
{

    /**
     * @param $request
     * @param Closure $next
     *
     * @return mixed
     */
    public function handle($request, Closure $next) {
        // Yanıtı alıyoruz
        $response = $next( $request );

        // Gelen istek "GET" türündeyse
        if( $request->isMethod( 'get' ) ) {
            // Etag oluşturuyoruz
            $etag = md5( $response->getContent() );
            $requestEtag = str_replace( '"', '', $request->getETags() );

            // Değişikliği kontrol ediyoruz
            if( $requestEtag && $requestEtag[0] == $etag ) {
                $response->setNotModified();
            }

            // Etag'i ayarlıyoruz
            $response->setEtag( $etag );
        }

        // Yanıtı gönderiyoruz
        return $response;
    }

}