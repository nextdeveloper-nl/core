<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Exceptions;

use Exception;
use Illuminate\Contracts\Container\Container;
use InvalidArgumentException;
use Psr\Log\LoggerInterface;
use ReflectionClass;
use Illuminate\Foundation\Exceptions\Handler as BaseHandler;

/**
 * Class Handler
 * @package PlusClouds\Core\Exceptions
 */
class Handler extends BaseHandler
{

    protected $ref;

    /**
     * A list of the exception types that should not be reported.
     *
     * @var array
     */
    protected $dontReport = [
        \Illuminate\Auth\AuthenticationException::class,
        \Illuminate\Auth\Access\AuthorizationException::class,
        \Symfony\Component\HttpKernel\Exception\HttpException::class,
        \Illuminate\Database\Eloquent\ModelNotFoundException::class,
        \Illuminate\Validation\ValidationException::class,
    ];

    public function __construct(Container $container) {
        parent::__construct( $container );

        $this->ref = genUuid();
    }

    /**
     * Report or log an exception.
     *
     * This is a great spot to send exceptions to Sentry, Bugsnag, etc.
     *
     * @param  \Exception  $e
     * @return mixed
     *
     * @throws \Exception
     */
    public function report(Exception $e) {
        if( $this->shouldntReport( $e ) ) {
            return false;
        }

//        if( isLoggedIn() ) {
//            $monolog = \Log::getMonolog();
//            $monolog->pushProcessor( function($item) {
//                $item['extra']['user'] = array_only( getAUUser()->toArray(), [ 'id', 'fullname' ] );
//
//                return $item;
//            } );
//        }

        if( method_exists( $e, 'report' ) ) {
            return $e->report();
        }

        try {
            $logger = $this->container->make( LoggerInterface::class );
        }
        catch( Exception $ex ) {
            throw $e; // throw the original exception
        }

        // Hatayı, saklıyoruz.
        $logger->error(
            $e->getMessage(),
            array_merge( $this->context(), [ 'exception' => $e ]
            ) );

        return true;
    }


    /**
     * Render an exception into an HTTP response.
     *
     * @param \Illuminate\Http\Request $request
     * @param Exception $e
     *
     * @return \Symfony\Component\HttpFoundation\Response
     * @throws \ReflectionException
     */
    public function render($request, Exception $e) {
        $map = config( 'core.exceptions.map' );

        foreach( $map as $coreException => $customException ) {
            if( ! ( $e instanceof $coreException ) ) {
                continue;
            }

            if(
                ! class_exists( $customException ) ||
                ! ( new ReflectionClass( $customException ) )->isSubclassOf( new ReflectionClass( AbstractCoreException::class ) )
            ) {
                throw new InvalidArgumentException(
                    sprintf(
                        "%s is not a valid exception class.",
                        $customException
                    )
                );
            }

            return parent::render( $request, new $customException( $e ) );
        }

        return parent::render( $request, $e );
    }

}