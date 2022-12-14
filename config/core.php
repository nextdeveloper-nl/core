<?php

return [
	'locales' => [
		'availables' => ['en', 'tr', 'nl'],
		'default'    => env('DEFAULT_LOCALE', 'en'),
	],

	'apiUrl' => [
		'local'      => '127.0.0.1:8000',
		'dev'        => '10.100.0.25',
		'production' => 'api.plusclouds.com'
	],

	'serviceDownloadBaseUrl' => "repo.plusclouds.com",
	'serviceDownloadPath'    => "/services/",

	'schedule' => [
		'exchange_rate' => env('EXCHANGE_RATE_SCHEDULE', false),
	],

	'mails' => [
		'logo'     => 'https://plusclouds.com.tr/assets/dark.png',
		'logo_alt' => 'PlusClouds Logo',
		'footer'   => '© 2013-2021 PlusClouds - Şef Bilişim Hizmetleri A.Ş. All rights reserved',
	],

	'rate_limit' => 60,

	'country_resolver' => [
		'default' => 'US',
	],

	'token' => [
		'service'     => 'PlusClouds\Account\Common\Services\Token\MailToken',
		'sms'         => [
			'length' => 6,
			'ttl'    => 300, // 5 dk
		],
		'email'       => [
			'length' => 15,
			'ttl'    => 3600, // 1 saat
		],
		'vm_transfer' => [
			'length' => 15,
			'ttl'    => 86400, // 1 gün
		],
	],

	'pushstream' => [
		'driver'     => 'PushStream',
		'base_url'   => 'https://api.plusclouds.com',
		'access_key' => null,
		'cert'       => null,
	],

	'exceptions' => [
		'map' => [
			'Illuminate\Auth\Access\AuthorizationException'                             => 'PlusClouds\Core\Exceptions\AuthorizationException',
			'Illuminate\Auth\AuthenticationException'                                   => 'PlusClouds\Core\Exceptions\AuthenticationException',
			'Illuminate\Validation\ValidationException'                                 => 'PlusClouds\Core\Exceptions\ValidationException',
			'Illuminate\Database\Eloquent\ModelNotFoundException'                       => 'PlusClouds\Core\Exceptions\ModelNotFoundException',
			'Symfony\Component\HttpKernel\Exception\NotFoundHttpException'              => 'PlusClouds\Core\Exceptions\NotFoundException',
			'Symfony\Component\HttpKernel\Exception\MethodNotAllowedHttpException'      => 'PlusClouds\Core\Exceptions\MethodNotAllowedException',
			'League\OAuth2\Server\Exception\OAuthServerException'                       => 'PlusClouds\Core\Exceptions\AuthenticationException',
			'PlusClouds\Cerebro\Hypervisor\XenServer\Exception\InvalidSessionException' => 'PlusClouds\Core\Exceptions\AuthenticationException',
			'PlusClouds\Cerebro\Common\Exception\RuntimeException'                      => 'PlusClouds\Core\Exceptions\RuntimeException',
			'Symfony\Component\HttpKernel\Exception\HttpException'                      => 'PlusClouds\Core\Exceptions\RuntimeException',
			'Symfony\Component\Debug\Exception\FatalThrowableError'                     => 'PlusClouds\Core\Exceptions\RuntimeException',
			'Symfony\Component\Debug\Exception\FatalErrorException'                     => 'PlusClouds\Core\Exceptions\RuntimeException',
		],
	],

	'middlewares' => [
		'http' => [
			'PlusClouds\Core\Http\Middleware\Locale',
			'PlusClouds\Core\Http\Middleware\XSSProtection',
			//            'PlusClouds\Core\Common\Cache\ResponseCache\Middlewares\CacheResponse',
		],

		'route' => [
			'throttle' => 'PlusClouds\Core\Http\Middleware\ThrottleRequests',
			'etag'     => 'PlusClouds\Core\Http\Middleware\ETag',
			//            'cacheResponse'      => 'PlusClouds\Core\Common\Cache\ResponseCache\Middlewares\CacheResponse',
			//            'doNotCacheResponse' => 'PlusClouds\Core\Common\Cache\ResponseCache\Middlewares\DoNotCacheResponse',
		],
	],

	'policies' => [
		'PlusClouds\Core\Database\Models\Discount' => 'PlusClouds\Core\Policies\DiscountPolicy',
		'PlusClouds\Core\Database\Models\Tag'      => 'PlusClouds\Core\Policies\TagPolicy',
		'PlusClouds\Core\Database\Models\Category' => 'PlusClouds\Core\Policies\CategoryPolicy',
	],

	'events' => [
		'Illuminate\Database\Events\QueryExecuted' => [
			'PlusClouds\Core\Common\Logger\QueryLogger',
		],
		'PlusClouds\Core\Events\JobUpdated'        => [
			'PlusClouds\Core\Events\Handlers\SendLogFile',
		],
	],

	'response_cache'   => [
		// Determine if the response cache middleware should be enabled.
		'enabled'                   => env('RESPONSE_CACHE_ENABLED', true),

		/*
		 *  The given class will determinate if a request should be cached. The
		 *  default class will cache all successful GET-requests.
		 *
		 *  You can provide your own class given that it implements the
		 *  CacheProfile interface.
		 */
		'cache_profile'             => 'PlusClouds\Core\Common\Cache\ResponseCache\CacheProfiles\CacheAllSuccessfulGetRequests',

		/*
		 * When using the default CacheRequestFilter this setting controls the
		 * default number of seconds responses must be cached.
		 */
		'cache_lifetime_in_seconds' => env('RESPONSE_CACHE_LIFETIME', 60 * 60 * 24 * 7),

		/*
		 * This setting determines if a http header named with the cache time
		 * should be added to a cached response. This can be handy when
		 * debugging.
		 */
		'add_cache_time_header'     => env('APP_DEBUG', true),

		/*
		 * This setting determines the name of the http header that contains
		 * the time at which the response was cached
		 */
		'cache_time_header_name'    => env('RESPONSE_CACHE_HEADER_NAME', 'laravel-responsecache'),

		/*
		 * Here you may define the cache store that should be used to store
		 * requests. This can be the name of any store that is
		 * configured in app/config/cache.php
		 */
		'cache_store'               => env('RESPONSE_CACHE_DRIVER', 'file'),

		/*
		 * Here you may define replacers that dynamically replace content from the response.
		 * Each replacer must implement the Replacer interface.
		 */
		'replacers'                 => [
			'PlusClouds\Core\Common\Cache\ResponseCache\Replacers\CsrfTokenReplacer',
		],

		/*
		 * If the cache driver you configured supports tags, you may specify a tag name
		 * here. All responses will be tagged. When clearing the responsecache only
		 * items with that tag will be flushed.
		 *
		 * You may use a string or an array here.
		 */
		'cache_tag'                 => '',

		/*
		 * This class is responsible for generating a hash for a request. This hash
		 * is used to look up an cached response.
		 */
		'hasher'                    => 'PlusClouds\Core\Common\Cache\ResponseCache\Hasher\DefaultHasher',

		// This class is responsible for serializing responses.
		'serializer'                => 'PlusClouds\Core\Common\Cache\ResponseCache\Serializers\DefaultSerializer',

	],

	// Registry ayarları
	'registry'         => [
		'driver' => 'database',
		'table'  => 'registries',
		'file'   => [
			'name'    => 'registries.json',
			'baseKey' => 'settings',
		],
		'cache'  => [
			'key' => 'plusclouds_registries',
		],
	],

	// Tek kullanımlık e-posta ayarları
	'disposable_email' => [
		'regex' => '/(?P<domain>[a-z0-9][a-z0-9\-]{1,63}\.[a-z\.]{2,6})$/i',
		'cache' => [
			'key'      => 'plusclouds_disposable_email',
			'lifetime' => null, // null = forever
		],
	],

	// Ip ayarları (ipv4,ipv6)
	'whitelist'        => [

	],

	'taggable' => [
		'delimiters' => ',',
	],

	'mattermost' => [
		'queue_failed_url' => 'http://10.100.0.54:8065/hooks/g1nhnie6z78oicfawkcs8wm9tc',
	],

	'log' => [
		'default_channel' => env('DEFAULT_LOG_CHANNEL', 'plusclouds-leo'),
		'query_logger'    => false,
	],

	'graylog' => [
		'enabled' => env('GRAYLOG_ENABLED', false),
		'host'    => env('GRAYLOG_HOST', null),
		'udpport' => env('GRAYLOG_UDP_PORT', null),
	],

	'configuration' => [
		'server' => [
			'url'      => env('CONFIGURATION_SERVER_URL'),
			'dn'       => env('CONFIGURATION_SERVER_DN'),
			'user'     => env('CONFIGURATION_SERVER_USERNAME'),
			'password' => env('CONFIGURATION_SERVER_PASSWORD'),
		],
	],

];
