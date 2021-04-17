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

        if ($request->filled('locale')) {
            if (in_array($request->get('locale'), $locales)) {
                $locale = strtolower($request->get('locale'));
            }
        }

        $request->merge(['locale' => $locale]);

        app()->setLocale($locale);

        return $next($request);
    }
}
