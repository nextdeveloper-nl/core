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
use GuzzleHttp\HandlerStack;
use GuzzleHttp\Middleware;
use Illuminate\Console\Command;
use Illuminate\Database\QueryException;
use PlusClouds\Core\Database\Models\DisposableEmail;
use Psr\Http\Message\RequestInterface;

/**
 * Class FetchDisposableEmailDomainsCommand
 * @package PlusClouds\Core\Console\Commands
 */
class FetchDisposableEmailDomainsCommand extends Command
{

    /**
     * @var string
     */
    protected $signature = 'plusclouds:fetch-disposable-email-domains';

    /**
     * @var string
     */
    protected $description = 'PlusClouds Disposable Email Domains';

    /**
     * @var Client
     */
    private $client;

    /**
     * @var string
     */
    private $cacheKey = 'disposable_email_domains_etag';

    /**
     * @var string
     */
    private $uri = 'https://raw.githubusercontent.com/andreis/disposable-email-domains/master/domains.json';

    /**
     * FetchDisposableEmailDomainsCommand constructor.
     */
    public function __construct() {
        parent::__construct();

        $stack = HandlerStack::create();
        $stack->push( Middleware::mapRequest( function(RequestInterface $request) {
            if( cache()->has( $this->cacheKey ) ) {
                return $request->withHeader( 'If-None-Match', '"'.cache( $this->cacheKey ).'"' );
            }

            return $request;
        } ) );

        $this->client = new Client( [
            'headers' => [ 'Accept' => 'application/json' ],
            'handler' => $stack,
        ] );
    }

    /**
     * @return int
     */
    public function handle() {
        $response = $this->client->get( $this->uri );

        if( $response->getStatusCode() !== 304 ) {
            if( ! empty( $etag = $response->getHeader( 'ETag' ) ) ) {
                $etag = str_replace( '"', '', $etag[0] );

                if( $etag !== cache( $this->cacheKey ) ) {
                    cache()->forget( $this->cacheKey );
                    cache()->forever( $this->cacheKey, $etag );
                }
            }

            $domains = json_decode( (string) $response->getBody(), true );

            foreach( $domains as $domain ) {
                if( preg_match( config( 'core.disposable_email.regex' ), $domain, $matches ) ) {
                    $domain = $matches['domain'];
                }

                try {
                    DisposableEmail::create( [
                        'domain' => $domain,
                    ] );
                }
                catch( QueryException $e ) {
                    $this->line( '[EXISTS] '.$domain );
                }
            }
        }

        return 1;
    }

}