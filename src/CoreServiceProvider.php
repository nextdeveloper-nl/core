<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core;

use GuzzleHttp\Client as GuzzleClient;
use PlusClouds\Core\Jobs\RemindRemindables;
use Illuminate\Broadcasting\BroadcastManager;
use Illuminate\Cache\Repository;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Container\Container;
use Illuminate\Contracts\Debug\ExceptionHandler;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Log;
use InvalidArgumentException;
use Monolog\Formatter\GelfMessageFormatter;
use PlusClouds\Core\Common\Broadcasting\Broadcasters\PushStreamBroadcaster;
use PlusClouds\Core\Common\Cache\ResponseCache\CacheProfiles\ICacheProfile;
use PlusClouds\Core\Common\Cache\ResponseCache\Hasher\IRequestHasher;
use PlusClouds\Core\Common\Cache\ResponseCache\ResponseCache;
use PlusClouds\Core\Common\Cache\ResponseCache\ResponseCacheRepository;
use PlusClouds\Core\Common\Cache\ResponseCache\Serializers\ISerializable;
use PlusClouds\Core\Common\Database\MariaDB\ConnectionFactory;
use PlusClouds\Core\Common\Logger\Monolog\Handler\GraylogHandler;
use PlusClouds\Core\Common\Registry\Drivers\IDriver;
use PlusClouds\Core\Common\Services\NiN\NiN;
use PlusClouds\Core\Common\Services\Token\IToken;
use PlusClouds\Core\Database\Models\Country;
use PlusClouds\Core\Database\Models\Ip2Location;
use PlusClouds\Core\Exceptions\Handler;
use PlusClouds\Core\Helpers\DebugMode;
use PlusClouds\Core\Http\Traits\Response\Responsable;
use Twilio\Rest\Client as TwilioClient;

/**
 * Class CoreServiceProvider.
 *
 * @package PlusClouds\Core
 */
class CoreServiceProvider extends AbstractServiceProvider {
    /**
     * @var bool
     */
    protected $defer = false;

    /**
     * @throws \Exception
     *
     * @return void
     */
    public function boot() {
        $this->publishes([
            __DIR__.'/../config/core.php' => config_path('core.php'),
        ], 'config');

        $this->bootChannelRoutes();

        $this->loadViewsFrom($this->dir.'/../resources/views', 'Core');

        $this->bootLogger();
        $this->bootErrorHandler();
        $this->bootModelBindings();

        if (app()->isLocal()) {
            $this->bootEloquentMacros();
        }

        $this->bootEvents();
        $this->bootSchedule();

        // $this->bootResponseCache();

        // $this->countryResolve();

        // $this->bootPushStreamBroadcaster();
        $this->bootTwilio();
        $this->bootNiN();
    }

    /**
     * @return void
     */
    public function register() {
//        $this->app->resolving( 'db', function($db, $app) {
//            $db->extend( 'mariadb', function($config, $name) use ($app) {
//                return ( new ConnectionFactory( $app ) )->make( $config, $name );
//            } );
//        } );

        // Register Response Api Macro
        $this->app['Illuminate\Contracts\Routing\ResponseFactory']->macro('api', function () {
            return new class() {
                use Responsable;
            };
        });

        $this->refreshConfigurations();
        $this->registerRegistry();
        $this->registerHelpers();
        $this->registerMiddlewares('core');
        $this->registerRoutes();
        $this->registerCommands();
        $this->registerTokenService();
        $this->registerScheduledJobs();

        $this->mergeConfigFrom(__DIR__.'/../config/core.php', 'core');
        $this->customMergeConfigFrom(__DIR__.'/../config/relation.php', 'relation');
    }

    /**
     * @return array
     */
    public function provides() {
        return ['core'];
    }

    /**
     * Hata i??leyiciyi de??i??tiriyoruz.
     *
     * @return void
     */
    public function bootErrorHandler() {
        $this->app->singleton(
            ExceptionHandler::class,
            Handler::class
        );
    }

    /**
     * @return void
     */
    private function bootChannelRoutes() {
        if (file_exists(($file = $this->dir.'/../config/channel.routes.php'))) {
            require_once $file;
        }
    }

    /**
     * @return void
     */
    public function bootLogger() {
        $monolog = Log::getMonolog();
        $monolog->pushProcessor(new \Monolog\Processor\WebProcessor());
        $monolog->pushProcessor(new \Monolog\Processor\MemoryUsageProcessor());
        $monolog->pushProcessor(new \Monolog\Processor\MemoryPeakUsageProcessor());

        if (true === (bool)env('GRAYLOG_ENABLED', false)) {
            $handler = new GraylogHandler();
            $handler->setFormatter(new GelfMessageFormatter());

            $monolog->pushHandler($handler);
        } else {
            $monolog->pushHandler(new \Monolog\Handler\StreamHandler(
                storage_path().DIRECTORY_SEPARATOR.'logs'.DIRECTORY_SEPARATOR.config('core.log.default_channel').'.log'
            ));
        }

        // Debug Class initialize
        $this->app->bind('DebugMode', DebugMode::class);
        $this->app->bind('WatchableJobLog', function () {
            $channel = 'watchable-jobs';

            if (true === (bool)env('GRAYLOG_ENABLED', false)) {
                $handler = new GraylogHandler();
                $handler->setFormatter(new GelfMessageFormatter());
            } else {
                $handler = new \Monolog\Handler\StreamHandler(
                    storage_path().DIRECTORY_SEPARATOR.'logs'.DIRECTORY_SEPARATOR.$channel.'.log'
                );
            }

            $logger = new DebugMode();
            $logger->addChannel($channel, $handler);

            return $logger->setChannel($channel);
        });

        $this->app->bind('QueryLogger', function () {
            $channel = 'query-log';

            if (true === (bool)env('GRAYLOG_ENABLED', false)) {
                $handler = new GraylogHandler();
                $handler->setFormatter(new GelfMessageFormatter());
            } else {
                $handler = new \Monolog\Handler\StreamHandler(
                    storage_path().DIRECTORY_SEPARATOR.'logs'.DIRECTORY_SEPARATOR.$channel.'.log'
                );
            }

            $logger = new DebugMode();
            $logger->addChannel($channel, $handler);

            return $logger->setChannel($channel);
        });
    }

    /**
     * @return void
     */
    protected function bootEloquentMacros() {
        Builder::macro('toSqlWithBindings', function () {
            $sql = $this->toSql();

            foreach ($this->getBindings() as $binding) {
                $value = is_numeric($binding) ? $binding : "'{$binding}'";
                $sql = preg_replace('/\?/', $value, $sql, 1);
            }

            return $sql;
        });

        Builder::macro('dd', function () {
            if (1 === func_num_args()) {
                $message = func_get_arg(0);
            }

            dump((empty($message) ? '' : $message.': ').$this->toSqlWithBindings());

            dd($this->get());
        });

        Builder::macro('dump', function () {
            if (1 === func_num_args()) {
                $message = func_get_arg(0);
            }

            dump((empty($message) ? '' : $message.': ').$this->toSqlWithBindings());

            return $this;
        });

        Builder::macro('log', function () {
            if (1 === func_num_args()) {
                $message = func_get_arg(0);
            }

            logger()->debug((empty($message) ? '' : $message.': ').$this->toSqlWithBindings());

            return $this;
        });
    }

    /**
     * @return void
     */
    protected function registerTokenService() {
        $this->app->bind(IToken::class, config('core.token.service'));
        $this->app->bind('TokenService', IToken::class);
    }

    /**
     * @return void
     */
    protected function bootEvents() {
        $configs = config()->all();

        foreach ($configs as $key => $value) {
            if (config()->has($key.'.events')) {
                foreach (config($key.'.events') as $event => $handlers) {
                    foreach ($handlers as $handler) {
                        $this->app['events']->listen($event, $handler);
                    }
                }
            }
        }
    }

    /**
     * @return void
     */
    protected function bootResponseCache() {
        $this->app->bind(ICacheProfile::class, function (Container $app) {
            return $app->make(config('core.response_cache.cache_profile'));
        });

        $this->app->bind(IRequestHasher::class, function (Container $app) {
            return $app->make(config('core.response_cache.hasher'));
        });

        $this->app->bind(ISerializable::class, function (Container $app) {
            return $app->make(config('core.response_cache.serializer'));
        });

        $this->app->when(ResponseCacheRepository::class)
            ->needs(Repository::class)
            ->give(function () : Repository {
                $repository = $this->app['cache']->store(config('core.response_cache.cache_store'));

                if ( ! empty(config('core.response_cache.cache_tag'))) {
                    return $repository->tags(config('core.response_cache.cache_tag'));
                }

                return $repository;
            });

        $this->app->singleton('responsecache', ResponseCache::class);
    }

    /**
     * Nginx Push Stream.
     *
     * @return void
     */
    protected function bootPushStreamBroadcaster() {
        $this->app->make(BroadcastManager::class)->extend('PushStream', function ($app, $config) {
            $client = new GuzzleClient([
                'base_uri' => config('core.pushstream.base_url'),
                'query'    => ! is_null(config('core.pushstream.access_key')) ? [
                    'access_key' => config('core.pushstream.access_key'),
                ] : null,
            ]);

            if ( ! is_null(config('core.pushstream.cert'))) {
                $client->setDefaultOption('verify', config('core.pushstream.cert'));
            }

            return new PushStreamBroadcaster($client);
        });
    }

    /**
     * Twilio servisini kaydeder.
     *
     * @return void
     */
    protected function bootTwilio() {
        $this->app->singleton('Twilio', function () {
            return new TwilioClient(env('TWILIO_ACCOUNT_SID'), env('TWILIO_AUTH_TOKEN'));
        });
    }

    /**
     * NiN servisini kaydeder.
     *
     * return @void
     */
    protected function bootNiN() {
        $this->app->singleton('NiN', NiN::class);
    }

    /**
     * Rota'lar?? kaydeder.
     *
     * @return void
     */
    protected function registerRoutes() {
        if ( ! $this->app->routesAreCached()) {
            $this->app['router']->prefix('v2')
                ->middleware(['api', 'team-finder'])
                ->namespace('PlusClouds\Core\Http\Controllers')
                ->group(__DIR__.DIRECTORY_SEPARATOR.'Http'.DIRECTORY_SEPARATOR.'api.routes.php');
        }
    }

    /**
     * @return void
     */
    protected function registerCommands() {
        if ($this->app->runningInConsole()) {
            $this->commands([
                'PlusClouds\Core\Console\Commands\FetchDisposableEmailDomainsCommand',
                'PlusClouds\Core\Console\Commands\MigrateExchangeRatesCommand',
                'PlusClouds\Core\Console\Commands\FetchExchangeRatesCommand',
                'PlusClouds\Core\Console\Commands\ObfuscateAccountDataCommand',
                // 'PlusClouds\Core\Common\Cache\ResponseCache\Commands\ClearCommand',
            ]);
        }
    }

    /**
     * Kay??t defteri ayarlar?? yap??l??yor.
     *
     * @return void
     */
    protected function registerRegistry() {
        $this->app->bind(IDriver::class, function ($app) {
            $driver = ucfirst(config('core.registry.driver', 'database'));
            $class = sprintf('PlusClouds\Core\Common\Registry\Drivers\%s', $driver);

            switch ($driver) {
                case 'Database':
                    $driver = new $class($app['db'], $app['config'], $app['cache.store']);

                    break;
                case 'File':
                    $driver = new $class($app['config']);

                    break;
                default:
                    throw new InvalidArgumentException('Unknown Registry Driver!');
            }

            return $driver;
        });

        $this->app->singleton('registry', IDriver::class);
    }

    /**
     * @return void
     */
    protected function bootSchedule() {
        $this->app->booted(function () {
            $schedule = $this->app->make(Schedule::class);
            $schedule->command('plusclouds:fetch-exchange-rates')
                ->withoutOverlapping(25)
                ->hourly()
                ->when(function () {
                    return config('core.schedule.exchange_rate');
                })
                ->before(function () {
                    logger()->info('Fetches Exchange Rates starting...');
                })
                ->after(function () {
                    logger()->info('Fetches Exchange Rates ended.');
                });
        });
    }

    /**
     * @throws \Exception
     */
    protected function countryResolve() {
        if ( ! $this->checkDatabaseConnection()) {
            return false;
        }

        $countryCode = config('core.country_resolver.default');

        if ( ! app()->isLocal()) {
            $locationList = cache()->rememberForever('ipLocationList', function () {
                return Ip2Location::all();
            });

            $ipAddr = request()->ip();
            $location = $locationList->where('ip_from', '<', ip2long($ipAddr))
                ->where('ip_to', '>', ip2long($ipAddr))
                ->first();

            if ( ! is_null($location)) {
                if ('-' != $location->country_code) {
                    $countryCode = $location->country_code;
                }
            }
        }

        $countries = cache()->rememberForever('countries', function () {
            return Country::all();
        });

        request()->attributes->set('country', ($country = $countries->where('code', $countryCode)->first()));

        app()->setLocale($country->locale);
    }

    private function refreshConfigurations() {
        $options = [
            'hosts'    => [env('CONFIGURATION_SERVER_URL')],
            'base_dn'  => preg_replace('/\{environment\}/', env('APP_ENV'), env('CONFIGURATION_SERVER_DN')),
        ];

        if (app()->isLocal()) {
            $options = array_merge($options, [
                'username' => env('CONFIGURATION_SERVER_USERNAME'),
                'password' => env('CONFIGURATION_SERVER_PASSWORD'),
            ]);
        }

        try {
            $ldap = new \Adldap\Adldap();
            $ldap->addProvider($options);

            $provider = $ldap->connect();

            $result = $provider->search()->query('(objectClass=*)');

            if ( ! count($result)) {
                logger()->debug('Configuration server data not found!');

                return;
            }

            $items = optional($result->first())->environmententry;

            for ($i = 0; $i < count($items); ++$i) {
                [$key, $value] = explode('=', $items[$i]);

                config()->set($key, $value);
            }

            $ldap->close();
        } catch (\Exception $e) {
            logger()->error($e->getMessage());
        }
    }

    /**
     * @return void
     */
    private function checkDatabaseConnection() {
        $isSuccessfull = false;

        try {
            \DB::connection()->getPdo();

            $isSuccessfull = true;
        } catch (\Exception $e) {
            die('Could not connect to the database. Please check your configuration. error:'.$e);
        }

        return $isSuccessfull;
    }

    private function registerScheduledJobs()
    {
        $this->app->booted(function () {
            $schedule = $this->app->make(Schedule::class);


            $schedule->call(function () {
                logger()->info('[CRM] Hourly jobs start');
                dispatch(new RemindRemindables())->onQueue('core/general');
            })->hourly();

        });
    }
}
