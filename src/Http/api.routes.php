<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

Route::prefix('countries')->group(function(){
    // Ülke listesini döndürür.
    Route::get( '/', 'CountryController@index' );

    // Ülke bilgisini döndürür.
    Route::get( '/{country}', 'CountryController@show' );

    // Yeni bir ülke oluşturur.
    Route::post( '/', 'CountryController@store' );

    // Varolan ülke bilgilerini günceller.
    Route::put( '/{country}', 'CountryController@update' );

    // Varolan bir ülkeyi siler.
    Route::delete( '/{country}', 'CountryController@destroy' );
});

Route::prefix( 'categories' )->group( function() {
    // Kategori listesini döndürür.
    Route::get( '/', 'CategoryController@index' );

    // Kategori bilgisini döndürür.
    Route::get( '/{category}', 'CategoryController@show' );

    // Yeni bir kategori oluşturur.
    Route::post( '/', 'CategoryController@store' );

    // Varolan kategori bilgilerini günceller.
    Route::put( '/{category}', 'CategoryController@update' );

    // Varolan bir kategoriyi siler.
    Route::delete( '/{category}', 'CategoryController@destroy' );
} );

Route::prefix( 'discounts' )->group( function() {
    // İndirim listesini döndürür.
    Route::get( '/', 'DiscountController@index' );

    // İndirim bilgisini döndürür.
    Route::get( '/{discount}', 'DiscountController@show' );

    // Yeni bir indirim oluşturur.
    Route::post( '/', 'DiscountController@store' );

    // Varolan indirim bilgilerini günceller.
    Route::put( '/{discount}', 'DiscountController@update' );

    // Varolan bir indirimi siler.
    Route::delete( '/{discount}', 'DiscountController@destroy' );
} );