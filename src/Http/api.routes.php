<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
Route::get('/', function () {
    return [
        'application'   => env('APP_NAME'),
        'health'        => 'ok',
    ];
});

Route::get('/module-exist', 'ModuleController@moduleExist');

Route::get('/service/{name}', function($name) {
    return File::get(public_path() . "/service_roles/${name}.zip");
});

Route::prefix('services')->group(function () {
    Route::prefix('roles/{serviceRole}')->group(function () {
        Route::put('ansible', "ServiceRoleController@ansibleUpdate");
        Route::put('service', "ServiceRoleController@serviceUpdate");
    });
});

Route::prefix('languages')->group(function () {
    // Dil listesini döndürür
    Route::get('/', 'LanguageController@index');
});

Route::prefix('core')->group(function() {
	Route::prefix('gift-codes')->group(function() {
		Route::get('/', 'GiftCodesController@index');
		Route::get('/code-exists', 'GiftCodesController@getBycode');
		Route::get('/{gift-code}', 'GiftCodesController@show');
	});

	Route::prefix('initiators')->group(function() {
		Route::post('/', 'InitiatorsController@execute');
		Route::get('/{moduleName}', 'InitiatorsController@index');
	});
});

Route::prefix('countries')->group(function () {
    // Ülke listesini döndürür.
    Route::get('/', 'CountryController@index');

    // Ülke bilgisini döndürür.
    Route::get('/{country}', 'CountryController@show');

    Route::middleware('auth:api')->group(function () {
        // Yeni bir ülke oluşturur.
        Route::post('/', 'CountryController@store');

        // Varolan ülke bilgilerini günceller.
        Route::put('/{country}', 'CountryController@update');

        // Varolan bir ülkeyi siler.
        Route::delete('/{country}', 'CountryController@destroy');
    });
});

Route::get('/currencies', 'CurrencyController@index');

Route::prefix('generator')->group(function () {
    Route::get('/password', 'PasswordGeneratorController@show');
    Route::get('/uuid', 'UuidGeneratorController@show');
    Route::get('/string', 'StringGeneratorController@show');
    Route::get('/number', 'NumberGeneratorController@show');
});

Route::prefix('password')->group(function () {
    Route::post('/strength-checker', 'PasswordStrengthCheckerController@show');
});

Route::prefix('tests')->middleware('auth:api')->group(function () {
    Route::get('/broadcast', 'TestBroadcastController@test');
});

Route::prefix('domains')->middleware('auth:api')->group(function () {
    // Alan adı listesini döndürür.
    Route::get('/', 'DomainController@index');

    // Alan adı bilgisini döndürür.
    Route::get('/{domain}', 'DomainController@show');

    // Yeni bir alan adı oluşturur.
    Route::post('/', 'DomainController@store');

    // Varolan alan adı bilgilerini günceller.
    Route::put('/{domain}', 'DomainController@update');

    // Varolan bir alan adını siler.
    Route::delete('/{domain}', 'DomainController@destroy');

    // Alan adını kullanıma kapatır.
    Route::put('/{domain}/lock', 'LockedDomainsController@update');

    // Alan adını kullanıma açar.
    Route::delete('/{domain}/unlock', 'LockedDomainsController@destroy');
});

Route::prefix('categories')->group(function () {
    // Kategori listesini döndürür.
    Route::get('/', 'CategoryController@index');

    // Kategori bilgisini döndürür.
    Route::get('/{category}', 'CategoryController@show');

    Route::middleware('auth:api')->group(function () {
        // Yeni bir kategori oluşturur.
        Route::post('/', 'CategoryController@store');

        // Varolan kategori bilgilerini günceller.
        Route::put('/{category}', 'CategoryController@update');

        // Varolan bir kategoriyi siler.
        Route::delete('/{category}', 'CategoryController@destroy');
    });
});

Route::prefix('discounts')->middleware('auth:api')->group(function () {
    // İndirim listesini döndürür.
    Route::get('/', 'DiscountController@index');

    // İndirim bilgisini döndürür.
    Route::get('/{discount}', 'DiscountController@show');

    // Yeni bir indirim oluşturur.
    Route::post('/', 'DiscountController@store');

    // Varolan indirim bilgilerini günceller.
    Route::put('/{discount}', 'DiscountController@update');

    // Varolan bir indirimi siler.
    Route::delete('/{discount}', 'DiscountController@destroy');

    Route::post('/attach', 'DiscountController@attach');

    Route::post('/detach', 'DiscountController@detach');
});

Route::prefix('email-templates')->middleware('auth:api')->group(function () {
    // E-posta şablon listesini döndürür.
    Route::get('/', 'EmailTemplateController@index');

    // E-posta şablon bilgisini döndürür.
    Route::get('/{template}', 'EmailTemplateController@show');

    // Yeni bir e-posta şablonu oluşturur.
    Route::post('/', 'EmailTemplateController@store');

    // Varolan e-posta şablon bilgilerini günceller.
    Route::put('/{template}', 'EmailTemplateController@update');

    // Varolan bir e-posta şablonunu siler.
    Route::delete('/{template}', 'EmailTemplateController@destroy');
});

Route::prefix('applications')->middleware('auth:api')->group(function () {
    Route::get('/', 'TagController@applications');
});

Route::prefix('tags')->group(function () {
    // Etiket listesini döndürür.
    Route::get('/', 'TagController@index');

    // Yeni bir etiket yaratır.
    Route::middleware('auth:api')->post('/', 'TagController@store');

    // İlgili Modele Bir Tag Atar
    Route::put('/attach', 'TagController@attach');

    // İlgili Modele Bir Tag Çıkartır
    Route::put('/detach', 'TagController@detach');

    // Varolan bir etiketi siler.
    Route::middleware('auth:api')->delete('/{tag}', 'TagController@destroy')->middleware('auth:api');
});

Route::prefix('mails')->middleware('auth:api')->group(function () {
    // Bir kullanıcıya e-posta gönderir.
    Route::post('/send', 'MailController@send');

    // Toplu e-posta gönderimi yapar.
    Route::post('/batch-send', 'MailController@batchSend');
});


Route::prefix('comments')->middleware('auth:api')->group(function () {
    Route::get('/', 'CommentController@index');
    Route::post('/', 'CommentController@store');
    Route::put('/{comment}', 'CommentController@update');
    Route::delete('/{comment}', 'CommentController@destroy');
});


Route::prefix('metas')->middleware('auth:api')->group(function () {
    Route::get('/', 'MetableController@index');
    Route::post('/', 'MetableController@store');
    Route::put('/{meta}', 'MetableController@update');
    Route::delete('/{meta}', 'MetableController@destroy');
});

Route::prefix('states')->middleware('auth:api')->group(function () {
    Route::post('/', 'StateController@store');
    Route::put('/{state}', 'StateController@update');
    Route::delete('/{state}', 'StateController@destroy');
});

Route::prefix('votes')->middleware('auth:api')->group(function () {
    Route::post('/', 'VoteController@store');
    Route::put('/{vote}', 'VoteController@update');
    Route::delete('/{vote}', 'VoteController@destroy');
});

Route::prefix('configs')->middleware('auth:api')->group(function () {
    Route::post('/', 'ConfigController@store');
    Route::put('/{config}', 'ConfigController@update');
    Route::delete('/{config}', 'ConfigController@destroy');
});

Route::prefix('addresses')->middleware('auth:api')->group(function () {
    Route::post('/', 'AddressController@store');
    Route::put('/{address}', 'AddressController@update');
    Route::delete('/{address}', 'AddressController@destroy');
});

Route::prefix('remindable')->middleware('auth:api')->group(function () {
    Route::get('/', 'RemindableController@index');
    Route::post('/', 'RemindableController@store');
    Route::put('/{remindable}', 'RemindableController@update');
    Route::delete('/{remindable}', 'RemindableController@destroy');
});