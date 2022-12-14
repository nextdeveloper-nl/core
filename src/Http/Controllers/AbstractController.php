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

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller;
use PlusClouds\Core\Http\Traits\Response\Responsable;

/**
 * Class AbstractController
 * @package PlusClouds\Core\Http\Controllers
 */
abstract class AbstractController extends Controller
{

    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
    use Responsable;

}