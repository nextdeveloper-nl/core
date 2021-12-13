<?php
/**
 * This file is part of the PlusClouds.Account library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;




use PlusClouds\Account\Database\Models\Address;

/**
 * Trait Addressable
 * @package PlusClouds\Account\Database\Traits
 */
trait Addressable
{

    /**
     * Adres bilgilerini döndürür.
     *
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function addresses() {
        return $this->morphMany( Address::class, 'addressable' );
    }

    /**
     * Yeni bir adres oluşturur.
     *
     * @param array $address
     * @param bool $isInvoiceAddress
     *
     * @return Address
     */
    public function address(array $address = [], $isInvoiceAddress = false) {
        $address['is_invoice_address'] = $isInvoiceAddress;

        return $this->addresses()->create( $address );
    }

    /**
     * Fatura adres bilgisini getirir.
     *
     * @return \PlusClouds\Core\Database\Models\Country
     */
    public function invoiceAddress() {
        return $this->addresses->where( 'is_invoice_address', true )->first();
    }

    /**
     * Fatura adresini normal adrese döndürür.
     *
     * @return bool
     */
    public function removeInvoiceAddress() {
        return $this->hasInvoiceAddress() && $this->invoiceAddress()->update( [ 'is_invoice_address' => false ] );
    }

    /**
     * Adres varlığını kontrol eder.
     *
     * @return bool
     */
    public function hasAddress() {
        return ! $this->addresses->isEmpty();
    }

    /**
     * Fatura adresi varlığını kontrol eder.
     *
     * @return bool
     */
    public function hasInvoiceAddress() {
        return ! $this->addresses->where( 'is_invoice_address', true )->isEmpty();
    }

}