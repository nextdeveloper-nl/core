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

use Illuminate\Routing\Controller;
use PlusClouds\Core\Http\Traits\Response\Responsable;

/**
 * Class AbstractController
 * @package PlusClouds\Core\Http\Controllers
 */
abstract class AbstractController extends Controller
{

    use Responsable;

    /**
     * @var \Illuminate\Contracts\Auth\Authenticatable|null
     */
    protected $authUser;

    /**
     * AbstractController constructor.
     */
    public function __construct() {
        $this->authUser = auth()->user();
    }

}