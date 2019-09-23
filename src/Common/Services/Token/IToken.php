<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Services\Token;


use Illuminate\Database\Eloquent\Model;

/**
 * Interface IToken
 * @package PlusClouds\Core\Common\Services\Token
 */
interface IToken
{

    /**
     * Token doğrulaması yapar.
     *
     * @param Model $model
     * @param string $token
     *
     * @return bool
     */
    public function verify(Model $model, $token);

    /**
     * Token üretir.
     *
     * @param Model $model
     *
     * @return string
     */
    public function generate(Model $model);

}