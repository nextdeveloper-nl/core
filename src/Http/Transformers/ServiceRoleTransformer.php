<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Transformers;

use League\Fractal\ParamBag;
use PlusClouds\Core\Database\Models\ServiceRole;
use PlusClouds\Core\Database\Models\Tag;

/**
 * Class TagTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class ServiceRoleTransformer extends AbstractTransformer
{
    /**
     * @param ServiceRole $serviceRole
     * @return array
     */
    public function transform(ServiceRole $serviceRole)
    {
        return $this->buildPayload([
            "name"           => $serviceRole->name,
            "url"            => $serviceRole->url,
            "service_status" => $serviceRole->service_status,
            "ansible_status" => $serviceRole->ansible_status
        ]);
    }
}
