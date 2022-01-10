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

use PlusClouds\Core\Http\Requests\ModuleExistRequest;

/**
 * Class ModuleController
 * @package PlusClouds\Core\Http\Controllers
 */
class ModuleController extends AbstractController
{
    /**
     * Checks if related module exists
     *
     * @param ModuleExistRequest $request
     *
     * @return mixed
     */
    public function moduleExist(ModuleExistRequest $request)
    {
        $exists = moduleExists($request->validated()['name']);

        return $this->withArray([
            'exists' => $exists,
        ]);
    }
}
