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
 * Class XSSProtection
 * @package PlusClouds\Core\Http\Middleware
 */
class XSSProtection
{

    /**
     * @param $request
     * @param Closure $next
     *
     * @return mixed
     */
    public function handle($request, Closure $next) {
        if( ! in_array( strtolower( $request->method ), [ 'post', 'put', 'patch' ] ) ) {
            return $next( $request );
        }

        $input = $request->all();

        // Kayıt ve doğrulama işlemlerinde şifre içerisinde özel karakterler bulunabilir.
        // Dolayısıyla password ve password_confirmation alanlarını bu işlemden geçirmiyoruz.
        unset( $input['password'], $input['password_confirmation'] );

        $walk = function($input) use (&$walk) {
            array_walk_recursive( $input, function(&$input, $walk) {
                if( ! is_array( $input ) ) {
                    $input = htmlspecialchars( $input, ENT_QUOTES | ENT_HTML5, 'UTF-8' );
                } else {
                    $walk( $input );
                }
            } );

            return $input;
        };

        $request->merge( $walk( $input ) );

        return $next( $request );
    }

}