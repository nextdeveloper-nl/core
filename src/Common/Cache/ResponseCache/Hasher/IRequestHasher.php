<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Cache\ResponseCache\Hasher;


use Illuminate\Http\Request;

/**
 * Interface IRequestHasher
 * @package PlusClouds\Core\Common\Cache\ResponseCache\Hasher
 */
interface IRequestHasher
{

    /**
     * @param Request $request
     *
     * @return string
     */
    public function getHashFor(Request $request);

}