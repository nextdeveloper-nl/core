<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Middleware;

use Closure;
use RuntimeException;
use Illuminate\Support\Str;
use Illuminate\Support\InteractsWithTime;
use Symfony\Component\HttpFoundation\Response;
use PlusClouds\Core\Common\Cache\RateLimiter;
use PlusClouds\Core\Exceptions\ThrottleRequestsException;

class ThrottleRequests
{

    use InteractsWithTime;

    /**
     * The rate limiter instance.
     *
     * @var \PlusClouds\Core\Common\Cache\RateLimiter
     */
    protected $limiter;

    /**
     * Create a new request throttler.
     *
     * @param  \PlusClouds\Core\Common\Cache\RateLimiter $limiter
     *
     * @return void
     */
    public function __construct(RateLimiter $limiter) {
        $this->limiter = $limiter;
    }

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  \Closure $next
     * @param  int|string $maxAttempts
     * @param  float|int $decayMinutes
     *
     * @return mixed
     * @throws \PlusClouds\Core\Exceptions\ThrottleRequestsException
     */
    public function handle($request, Closure $next, $maxAttempts = 60, $decayMinutes = 1) {
        $key = $this->resolveRequestSignature( $request );

        $maxAttempts = $this->resolveMaxAttempts( $request, $maxAttempts );

        if( $this->limiter->tooManyAttempts( $key, $maxAttempts ) ) {
            throw $this->buildException( $key, $maxAttempts );
        }

        $this->limiter->hit( $key, $decayMinutes );

        $response = $next( $request );

        return $this->addHeaders(
            $response, $maxAttempts,
            $this->calculateRemainingAttempts( $key, $maxAttempts )
        );
    }

    /**
     * Resolve the number of attempts if the user is authenticated or not.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  int|string $maxAttempts
     *
     * @return int
     */
    protected function resolveMaxAttempts($request, $maxAttempts) {
        if( Str::contains( $maxAttempts, '|' ) ) {
            $maxAttempts = explode( '|', $maxAttempts, 2 )[ $request->user() ? 1 : 0 ];
        }

        if( ! is_numeric( $maxAttempts ) && $request->user() ) {
            $maxAttempts = $request->user()->{$maxAttempts};
        } else {
            $maxAttempts = config( 'core.rate_limit' );
        }

        return (int) $maxAttempts;
    }

    /**
     * Resolve request signature.
     *
     * @param  \Illuminate\Http\Request $request
     *
     * @return string
     * @throws \RuntimeException
     */
    protected function resolveRequestSignature($request) {
        if( $user = $request->user() ) {
            return sha1( $user->getAuthIdentifier() );
        }

        if( $route = $request->route() ) {
            return sha1( $route->getDomain().'|'.$request->ip() );
        }

        throw new RuntimeException( 'Unable to generate the request signature. Route unavailable.' );
    }

    /**
     * Create a 'too many attempts' exception.
     *
     * @param  string $key
     * @param  int $maxAttempts
     *
     * @return \PlusClouds\Core\Exceptions\ThrottleRequestsException
     */
    protected function buildException($key, $maxAttempts) {
        $retryAfter = $this->getTimeUntilNextRetry( $key );

        $headers = $this->getHeaders(
            $maxAttempts,
            $this->calculateRemainingAttempts( $key, $maxAttempts, $retryAfter ),
            $retryAfter
        );

        return new ThrottleRequestsException(
            'Too Many Attempts.', null, $headers
        );
    }

    /**
     * Get the number of seconds until the next retry.
     *
     * @param  string $key
     *
     * @return int
     */
    protected function getTimeUntilNextRetry($key) {
        return $this->limiter->availableIn( $key );
    }

    /**
     * Add the limit header information to the given response.
     *
     * @param  \Symfony\Component\HttpFoundation\Response $response
     * @param  int $maxAttempts
     * @param  int $remainingAttempts
     * @param  int|null $retryAfter
     *
     * @return \Symfony\Component\HttpFoundation\Response
     */
    protected function addHeaders(Response $response, $maxAttempts, $remainingAttempts, $retryAfter = null) {
        $response->headers->add(
            $this->getHeaders( $maxAttempts, $remainingAttempts, $retryAfter )
        );

        return $response;
    }

    /**
     * Get the limit headers information.
     *
     * @param  int $maxAttempts
     * @param  int $remainingAttempts
     * @param  int|null $retryAfter
     *
     * @return array
     */
    protected function getHeaders($maxAttempts, $remainingAttempts, $retryAfter = null) {
        $headers = [
            'X-RateLimit-Limit'     => $maxAttempts,
            'X-RateLimit-Remaining' => $remainingAttempts,
        ];

        if( ! is_null( $retryAfter ) ) {
            $headers['Retry-After'] = $retryAfter;
            $headers['X-RateLimit-Reset'] = $this->availableAt( $retryAfter );
        }

        return $headers;
    }

    /**
     * Calculate the number of remaining attempts.
     *
     * @param  string $key
     * @param  int $maxAttempts
     * @param  int|null $retryAfter
     *
     * @return int
     */
    protected function calculateRemainingAttempts($key, $maxAttempts, $retryAfter = null) {
        if( is_null( $retryAfter ) ) {
            return $this->limiter->retriesLeft( $key, $maxAttempts );
        }

        return 0;
    }

}