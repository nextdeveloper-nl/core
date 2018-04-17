<?php

return [

    // Dil ayarları
    'locale' => [
        'available' => [ 'tr', 'en' ],
        'default'   => 'en',
    ],

    // Registry ayarları
    'registry' => [
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
    'whitelist' => [

    ],

    'taggable' => [
        'delimiters' => ',',
    ],

];