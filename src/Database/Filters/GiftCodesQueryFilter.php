<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Filters;

use PlusClouds\Marketplace\Database\Models\Catalog;

/**
 * Class DomainQueryFilter
 * @package PlusClouds\Core\Database\Filters
 */
class GiftCodesQueryFilter extends AbstractQueryFilter
{
    /**
     * Filters gift cards with gift code
     *
     * @return mixed
     */
    public function giftCode($code)
    {
        return $this->builder->where('gift_code', '=', $code);
    }

    /**
     * Filters gift cards with product catalog
     *
     * @return mixed
     */
    public function productCatalog(Catalog $productCatalog)
    {
        return $this->builder->where('product_catalog_id', '=', $productCatalog->id);
    }

    /**
     * Filters gift card with modes. Modes are; percentage, value
     *
     * @param $name
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function giftMode($mode)
    {
        return $this->builder->where('gift_mode', '=', $mode);
    }

	/**
	 * Filters gift codes with specific gift value
	 *
	 * @param $value
	 * @return \Illuminate\Database\Eloquent\Builder
	 */
	public function giftValue($value) {
		return $this->builder->where('gift_value', '=', $value);
	}
}
