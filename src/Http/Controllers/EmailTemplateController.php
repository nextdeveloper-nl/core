<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Controllers;

use Illuminate\Database\Eloquent\ModelNotFoundException;
use PlusClouds\Core\Database\Models\EmailTemplate;
use PlusClouds\Core\Http\Requests\EmailTemplateStoreRequest;
use PlusClouds\Core\Http\Requests\EmailTemplateUpdateRequest;
use PlusClouds\Core\Http\Transformers\EmailTemplateTransformer;

/**
 * Class EmailTemplateController.
 *
 * @package PlusClouds\Core\Http\Controllers
 */
class EmailTemplateController extends AbstractController {
    /**
     * E-posta şablon listesini döndürür.
     *
     * @throws \Throwable
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index() {
        $templates = EmailTemplate::all();

        throw_if($templates->isEmpty(), ModelNotFoundException::class, 'Could not find any email templates.');

        return $this->withCollection($templates, app(EmailTemplateTransformer::class));
    }

    /**
     * E-posta şablon bilgisini döndürür.
     *
     * @param EmailTemplate $template
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(EmailTemplate $template) {
        return $this->withItem($template, app(EmailTemplateTransformer::class));
    }

    /**
     * Yeni bir e-posta şablonu oluşturur.
     *
     * @param EmailTemplateStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(EmailTemplateStoreRequest $request) {
        $data = collect($request->validated())
            ->when($request->filled('_locale'), function ($collection) use ($request) {
                return $collection->put('locale', $request->get('_locale'));
            })
            ->transform(function ($value, $key) {
                if ('subject' == $key || 'body' == $key) {
                    return htmlspecialchars_decode($value, ENT_QUOTES | ENT_HTML5);
                }

                return $value;
            })
            ->forget('_locale');

        $template = EmailTemplate::create($data->toArray());

        return $this->setStatusCode(201)
            ->withItem($template->fresh(), app(EmailTemplateTransformer::class));
    }

    /**
     * Varolan e-posta şablon bilgilerini günceller.
     *
     * @param EmailTemplateUpdateRequest $request
     * @param EmailTemplate              $template
     *
     * @return mixed
     */
    public function update(EmailTemplateUpdateRequest $request, EmailTemplate $template) {
        $template->update($request->validated());

        return $this->noContent();
    }

    /**
     * Varolan bir e-posta şablonunu siler.
     *
     * @param EmailTemplate $template
     *
     * @throws \Exception
     *
     * @return mixed
     */
    public function delete(EmailTemplate $template) {
        $this->authorize('destroy', $template);

        $template->delete();

        return $this->noContent();
    }
}
