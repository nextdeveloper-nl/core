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
 * Class UuidGeneratorController
 * @package PlusClouds\Core\Http\Controllers
 */
class UuidGeneratorController extends AbstractController
{

    /**
     * @param Request $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Request $request) {
        $request->validate( [
            'prefix' => 'nullable|size:3',
        ] );

        return $this->withItem( [ 'uuid' => genUuid( $request->get( 'prefix' ) ) ], function($item) {
            return $item;
        } );
    }
}
