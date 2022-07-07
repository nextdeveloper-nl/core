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
use PlusClouds\Account\Http\Transformers\AccountTransformer;
use PlusClouds\Core\Database\Models\Domain;
use PlusClouds\Core\Database\Models\GiftCode;
use PlusClouds\Core\Exceptions\ModuleNotFoundException;
use PlusClouds\Marketplace\Database\Models\Catalog;
use PlusClouds\Marketplace\Http\Transformers\CatalogTransformer;
use PlusClouds\Marketplace\Http\Transformers\ProductTransformer;

/**
 * Class DomainTransformer.
 *
 * @package PlusClouds\Core\Http\Transformers
 */
class GiftCodesTransformer extends AbstractTransformer
{
    /**
     * @var array
     */
    protected $availableIncludes = ['productCatalog'];

    /**
     * @param Domain $domain
     *
     * @return array
     */
    public function transform(GiftCode $giftCode)
    {
		$isMine = ($giftCode->user_id == getAUUser()->id) ? true : false;

		$productId = null;
		$productCatalogId = null;

		if($giftCode->product_id) {
			/*
			 * Burada class'ı include etmedik zira Code'da product_id yok ise exception fırlatsın istemedim.
			 */

			if(!class_exists('\PlusClouds\Marketplace\Database\Models\Product')) {
				throw new ModuleNotFoundException('Marketplace is not found, that is why you cannot reach to gift codes with marketplace products.');
			}

			$productId = \PlusClouds\Marketplace\Database\Models\Product::where('id', $giftCode->product_id)->first()->id_ref;
			$productCatalogId = \PlusClouds\Marketplace\Database\Models\Catalog::where('id', $giftCode->product_catalog_id)->first()->id_ref;
		}

        return $this->buildPayload([
            'id'                    => $giftCode->id_ref,
            'code'                  => $isMine ? $giftCode->code : 'Not available',
			//  This is a virtual field
			'is_used'               => $giftCode->account_id ? true : false,
            'order_number'          => $giftCode->order_number,
            'line_number'           => $giftCode->line_number,
	        'product_id'            => $productId,
	        'product_catalog_id'    =>  $productCatalogId,
	        'gift_mode'             =>  $giftCode->gift_mode,
	        'gift_value'            =>  $giftCode->gift_value,
	        'created_at'            =>  $giftCode->created_at->toIso8601String()
        ]);
    }

	public function includeProductCatalog(GiftCode $giftCode, ParamBag $paramBag = null) {
		$catalog = Catalog::where('id', $giftCode->product_catalog_id)->first();

		return $this->item($catalog, new CatalogTransformer($paramBag));
	}
}
