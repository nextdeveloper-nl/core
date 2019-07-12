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


use PlusClouds\Core\Database\Models\Language;

/**
 * Class LanguageTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class LanguageTransformer extends AbstractTransformer
{

    /**
     * @param Language $language
     *
     * @return array
     */
    public function transform(Language $language) {
        return $this->buildPayload( [
            'code'          => $language->code,
            'name'          => $language->name,
            'currency_code' => $language->currency_code,
            'is_default'    => $language->is_default,
            'is_active'     => $language->is_active,
        ] );
    }

}