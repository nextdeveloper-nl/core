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

/**
 * Class Locale.
 *
 * @package PlusClouds\Core\Http\Middleware
 */
class Locale {
    /**
     * @param $request
     * @param Closure $next
     *
     * @return mixed
     */
    public function handle($request, Closure $next) {
        $locales = config('core.locales.availables');
        $locale = optional(getAUUser())->default_locale ?? config('core.locales.default');

        $payload = collect($request->all())
            ->map(function ($value, $key) {
                if (in_array($key, ['locale', '_locale'])) {
                    return strtolower($value);
                }

                return $value;
            })
            ->when($request->filled('locale'), function ($collection) use (&$locale, $locales) {
                if (in_array($collection->get('locale'), $locales)) {
                    $locale = $collection->get('locale');
                } else {
                    $collection->put('locale', $locale);
                }

                return $collection;
            });

        $request->merge($payload->toArray());

        app()->setLocale($locale);

        return $next($request);
    }
}
