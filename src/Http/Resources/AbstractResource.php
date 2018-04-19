<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Resources;

use Illuminate\Http\Resources\Json\Resource;
use Illuminate\Support\Traits\Macroable;
use PlusClouds\Core\Common\Contracts\IResource;

/**
 * Class AbstractResource
 * @package PlusClouds\Core\Http\Resources
 */
abstract class AbstractResource extends Resource implements IResource
{

    use Macroable;

    /**
     * @var array
     */
    protected $withoutFields = [];

    /**
     * @param array $fields
     */
    public function hide(array $fields = []) {
        $this->withoutFields = $fields;
    }

    /**
     * @param $fields
     *
     * @return array
     */
    protected function filterFields($fields) {
        return collect( $fields )->forget( $this->withoutFields )->toArray();
    }

}