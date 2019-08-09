<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Controllers;


use Illuminate\Http\Request;
use PlusClouds\Core\Helpers\PasswordComplexity;

/**
 * Class PasswordStrengthCheckerController
 * @package PlusClouds\Core\Http\Controllers
 */
class PasswordStrengthCheckerController extends AbstractController
{

    /**
     * @param Request $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Request $request) {
        return $this->withItem( [ 'result' => resolve( PasswordComplexity::class )->check( $request->get( 'password' ) ) ], function($item) {
            return $item;
        } );
    }

}