<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Enums;


use BenSampo\Enum\Enum;

/**
 * Class HookBehavior
 * @package PlusClouds\Core\Common\Enums
 */
class HookBehavior extends Enum
{

    /**
     * @var string
     */
    const BEFORE = 'before';

    /**
     * @var string
     */
    const AFTER = 'after';

}