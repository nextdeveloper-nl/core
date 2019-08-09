<?php

return [
    'rate_limit' => 60,

    'country_resolver' => [
        'default' => 'TR',
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
        ],
    ],

    'middlewares' => [
        'http' => [
            'PlusClouds\Core\Http\Middleware\XSSProtection',
            'PlusClouds\Core\Http\Middleware\CountryResolver',
        ],

        'route' => [
            'throttle' => 'PlusClouds\Core\Http\Middleware\ThrottleRequests',
            'etag'     => 'PlusClouds\Core\Http\Middleware\ETag',
        ],
    ],

    'policies'         => [
        'PlusClouds\Core\Database\Models\Hook' => 'PlusClouds\Core\Policies\HookPolicy',
        'PlusClouds\Core\Database\Models\Tag'  => 'PlusClouds\Core\Policies\TagPolicy',
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

];