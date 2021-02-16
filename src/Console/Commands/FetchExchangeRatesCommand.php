<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Console\Commands;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;
use Illuminate\Console\Command;
use Illuminate\Support\Carbon;
use PlusClouds\Core\Database\Models\ExchangeRate;
use Psr\Http\Message\ResponseInterface;
use SimpleXMLElement;

/**
 * Class FetchExchangeRatesCommand.
 *
 * @package PlusClouds\Core\Console\Commands
 */
class FetchExchangeRatesCommand extends Command {
    /**
     * @var string
     */
    protected $signature = 'plusclouds:fetch-exchange-rates';

    /**
     * @var string
     */
    protected $description = 'PlusClouds Fetch Exchange Rates';

    /**
     * @var string
     */
    private $url = 'http://www.tcmb.gov.tr/kurlar/today.xml';

    /**
     * @var array
     */
    private $currencies = [
        'USD', 'EUR', 'AUD', 'GBP', 'CAD', 'JPY', 'RUB',
    ];

    private $client;

    public function __construct() {
        parent::__construct();

        $this->client = new Client([
            'headers' => [
                'Accept' => 'application/xml',
            ],
        ]);
    }

    /**
     * @return int
     */
    public function handle() {
        $rate = ExchangeRate::latest()->first();

        $request = new \GuzzleHttp\Psr7\Request('GET', $this->url);
        $promise = $this->client->sendAsync($request)
            ->then(function (ResponseInterface $response) use ($rate) {
                $body = $response->getBody()->getContents();
                $xmlReader = new SimpleXMLElement($body);
                $lastModified = Carbon::createFromTimestamp(strtotime($response->getHeader('last-modified')[0]));

                $lmd = optional($rate)->last_modified ?? now();

                if ($lastModified->diffInSeconds($lmd) > 0) {
                    foreach ($xmlReader->Currency as $currency) {
                        $code = (string)$currency->attributes()->Kod;

                        if (in_array($code, $this->currencies)) {
                            ExchangeRate::create([
                                'code'          => $code,
                                'rate'          => number_format(((float)$currency->ForexSelling / (int)$currency->Unit), 4),
                                'last_modified' => $lastModified->format('Y-m-d H:i:s'),
                            ]);
                        }
                    }
                }
            }, function (RequestException $e) {
                logger()->error("[CORE/FetchExchangeRatesCommand] Exchange rates cannot be obtained. \r\n".$e->getMessage());
            });

        $promise->wait();

        return 1;
    }
}
