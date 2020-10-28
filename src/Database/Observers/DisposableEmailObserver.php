<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Observers;

use Illuminate\Database\Eloquent\Model;
use PlusClouds\Core\Database\Models\DisposableEmail;

/**
 * Class DisposableEmailObserver
 * @package PlusClouds\Core\Database\Observers
 */
class DisposableEmailObserver extends AbstractObserver
{

    /**
     * @param Model $model
     *
     * @throws \Exception
     */
    public function saving(Model $model)
    {
        $domain = $model->domain;
        $params = explode('.', $domain);

        // Eğer eklenmeye çalışılan domain, subdomain ise domain olarak ekliyoruz.
        if (sizeof($params) > 2) {
            if (preg_match(config('core.disposable_email.regex'), $model->domain, $matches)) {
                $model->domain = $matches['domain'];
            }
        }

        if (cache()->has('core.disposable_email.cache.key')) {
            $this->forgetCache();
        }
    }

    /**
     * @param Model $model
     *
     * @throws \Exception
     */
    public function saved(Model $model)
    {
        $this->regenerateCache();
    }

    /**
     * @param Model $model
     *
     * @throws \Exception
     */
    public function deleting(Model $model)
    {
        $this->forgetCache();
    }

    /**
     * @param Model $model
     *
     * @throws \Exception
     */
    public function deleted(Model $model)
    {
        $this->regenerateCache();
    }

    /**
     * @throws \Exception
     */
    private function regenerateCache()
    {
        if (is_null(config('core.disposable_email.cache.lifetime'))) {
            cache()->rememberForever(config('core.disposable_email.cache.key'), function () {
                return DisposableEmail::all();
            });
        } else {
            cache()->remember(
                config('core.disposable_email.cache.key'),
                config(
                    'core.disposable_email.cache.lifetime'
                ),
                function () {
                    return DisposableEmail::all();
                }
            );
        }
    }

    /**
     * @throws \Exception
     */
    private function forgetCache()
    {
        cache()->forget(config('core.disposable_email.cache.key'));
    }
}
