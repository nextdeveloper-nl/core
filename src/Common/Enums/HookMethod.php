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
 * Class HookMethod
 * @package PlusClouds\Core\Common\Enums
 */
class HookMethod extends Enum
{

    /**
     * @var string
     */
    const GET = 'GET';

    /**
     * @var string
     */
    const POST = 'POST';

    /**
     * @var string
     */
    const PUT = 'PUT';

    /**
     * @var string
     */
    const PATCH = 'PATCH';

    /**
     * @var string
     */
    const DELETE = 'DELETE';

}