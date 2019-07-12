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


use PlusClouds\Core\Database\Models\Language;
use PlusClouds\Core\Http\Transformers\LanguageTransformer;

/**
 * Class LanguageController
 * @package PlusClouds\Core\Http\Controllers
 */
class LanguageController extends AbstractController
{

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function index() {
        return $this->withCollection( Language::all(), app( LanguageTransformer::class ) );
    }

}