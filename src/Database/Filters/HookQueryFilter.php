<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Filters;


/**
 * Class HookQueryFilter
 * @package PlusClouds\Core\Database\Filters
 */
class HookQueryFilter extends AbstractQueryFilter
{

    /**
     * @param string $action
     *
     * @return mixed
     */
    public function action($action) {
        return $this->builder->where( 'action', $action );
    }

    /**
     * @param $behavior
     *
     * @return mixed
     */
    public function behavior($behavior) {
        return $this->builder->where( 'behavior', $behavior );
    }

}