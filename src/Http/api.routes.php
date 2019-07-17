<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

Route::prefix( 'languages' )->group( function() {
    // Dil listesini döndürür
    Route::get( '/', 'LanguageController@index' );
} );

Route::prefix( 'countries' )->group( function() {
    // Ülke listesini döndürür.
    Route::get( '/', 'CountryController@index' );

    // Ülke bilgisini döndürür.
    Route::get( '/{country}', 'CountryController@show' );

    Route::middleware( 'auth:api' )->group( function() {
        // Yeni bir ülke oluşturur.
        Route::post( '/', 'CountryController@store' );

        // Varolan ülke bilgilerini günceller.
        Route::put( '/{country}', 'CountryController@update' );

        // Varolan bir ülkeyi siler.
        Route::delete( '/{country}', 'CountryController@destroy' );
    } );
} );

Route::prefix( 'generator' )->group( function() {
    Route::get( '/password', 'PasswordGeneratorController@show' );
    Route::get( '/uuid', 'UuidGeneratorController@show' );
} );

Route::prefix( 'domains' )->middleware( 'auth:api' )->group( function() {
    // Alan adı listesini döndürür.
    Route::get( '/', 'DomainController@index' );

    // Alan adı bilgisini döndürür.
    Route::get( '/{domain}', 'DomainController@show' );

    // Yeni bir alan adı oluşturur.
    Route::post( '/', 'DomainController@store' );

    // Varolan alan adı bilgilerini günceller.
    Route::put( '/{domain}', 'DomainController@update' );

    // Varolan bir alan adını siler.
    Route::delete( '/{domain}', 'DomainController@destroy' );

    // Alan adını kullanıma kapatır.
    Route::put( '/{domain}/lock', 'LockedDomainsController@update' );

    // Alan adını kullanıma açar.
    Route::delete( '/{domain}/unlock', 'LockedDomainsController@destroy' );
} );

Route::prefix( 'categories' )->group( function() {
    // Kategori listesini döndürür.
    Route::get( '/', 'CategoryController@index' );

    // Kategori bilgisini döndürür.
    Route::get( '/{category}', 'CategoryController@show' );

    Route::middleware( 'auth:api' )->group( function() {
        // Yeni bir kategori oluşturur.
        Route::post( '/', 'CategoryController@store' );

        // Varolan kategori bilgilerini günceller.
        Route::put( '/{category}', 'CategoryController@update' );

        // Varolan bir kategoriyi siler.
        Route::delete( '/{category}', 'CategoryController@destroy' );
    } );
} );

Route::prefix( 'discounts' )->middleware( 'auth:api' )->group( function() {
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

Route::prefix( 'email-templates' )->middleware( 'auth:api' )->group( function() {
    // E-posta şablon listesini döndürür.
    Route::get( '/', 'EmailTemplateController@index' );

    // E-posta şablon bilgisini döndürür.
    Route::get( '/{template}', 'EmailTemplateController@show' );

    // Yeni bir e-posta şablonu oluşturur.
    Route::post( '/', 'EmailTemplateController@store' );

    // Varolan e-posta şablon bilgilerini günceller.
    Route::put( '/{template}', 'EmailTemplateController@update' );

    // Varolan bir e-posta şablonunu siler.
    Route::delete( '/{template}', 'EmailTemplateController@destroy' );
} );

Route::prefix( 'hooks' )->middleware( 'auth:api' )->group( function() {
    // Kanca listesini döndürür.
    Route::get( '/', 'HookController@index' );

    // Kanca bilgisini döndürür.
    Route::get( '/{hook}', 'HookController@show' );

    // Yeni bir kanca oluşturur.
    Route::post( '/', 'HookController@store' );

    // Varolan kanca bilgilerini günceller.
    Route::put( '/{hook}', 'HookController@update' );

    // Varolan bir kancayı siler.
    Route::delete( '/{hook}', 'HookController@destroy' );
} );

Route::prefix( 'applications' )->middleware( 'auth:api' )->group( function() {
    Route::get( '/', 'TagController@index' );
} );

Route::prefix( 'tags' )->group( function() {
    // Etiket listesini döndürür.
    Route::get( '/', 'TagController@index' );

    // Yeni bir etiket yaratır.
    Route::middleware( 'auth:api' )->post( '/', 'TagController@store' );

    // Varolan bir etiketi siler.
    Route::delete( '/{tag}', 'TagController@destroy' )->middleware( 'auth:api' );
} );

Route::prefix( 'mails' )->middleware( 'auth:api' )->group( function() {
    // Bir kullanıcıya e-posta gönderir.
    Route::post( '/send', 'MailController@send' );

    // Toplu e-posta gönderimi yapar.
    Route::post( '/batch-send', 'MailController@batchSend' );
} );