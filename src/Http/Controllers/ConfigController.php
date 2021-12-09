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


use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use PlusClouds\Core\Database\Models\Meta;
use PlusClouds\Core\Http\Requests\Config\ConfigStoreRequest;
use PlusClouds\Core\Http\Requests\Config\ConfigUpdateRequest;

/**
 * Class ConfigController
 * @package PlusClouds\Core\Http\Controllers
 */
class ConfigController extends AbstractController
{

    public function store(ConfigStoreRequest $request)
    {

        $data = $request->validated();

        $objectArr = findObjectFromClassName($data['object'], $data['object_id'], 'Configable');

        Meta::create([
            'value' => $data['value'],
            'key' => 'config.'.$data['key'],
            'metable_type' => $objectArr[0],
            'metable_id' => $objectArr[1]
        ]);

        return $this->noContent();
    }

    public function update(ConfigUpdateRequest $request, Meta $meta)
    {

        $meta->value = $request->validated()['value'];
        $meta->save();

        return $this->noContent();
    }


    public function destroy(Meta $meta)
    {

        $meta->destroy();

        return $this->noContent();
    }
}