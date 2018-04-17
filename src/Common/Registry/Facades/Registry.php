<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Registry\Facades;


use Illuminate\Support\Facades\Facade;

/**
 * Class Registry
 * @package PlusClouds\Core\Common\Registry\Facades
 */
class Registry extends Facade
{

    /**
     * Get the registered name of the component.
     *
     * @return string
     */
    protected static function getFacadeAccessor() {
        return 'registry';
    }

}