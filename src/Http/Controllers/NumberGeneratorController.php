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

/**
 * Class NumberGeneratorController
 * @package PlusClouds\Core\Http\Controllers
 */
class NumberGeneratorController extends AbstractController
{

    /**
     * @param Request $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Request $request) {
        $request->validate( [
            'length' => 'required|Integer|between:5,15',
        ] );

        return $this->withItem( [ 'number' => generateRandomNumber( $request->get( 'length' ) ) ], function($item) {
            return $item;
        } );
    }

}