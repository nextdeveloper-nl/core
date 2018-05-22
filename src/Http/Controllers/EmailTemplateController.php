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
 * Class EmailTemplateController
 * @package PlusClouds\Core\Http\Controllers
 */
class EmailTemplateController extends AbstractController
{

    /**
     * E-posta şablon listesini döndürür.
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function index() {
        $templates = EmailTemplate::all();

        throw_if( $templates->isEmpty(), ModelNotFoundException::class, 'Could not find the records you are looking for.' );

        return $this->withCollection( $templates, app( EmailTemplateTransformer::class ) );
    }

    /**
     * E-posta şablon bilgisini döndürür.
     *
     * @param EmailTemplate $template
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(EmailTemplate $template) {
        return $this->withItem( $template, app( EmailTemplateTransformer::class ) );
    }

    /**
     * Yeni bir e-posta şablonu oluşturur.
     *
     * @param EmailTemplateStoreRequest $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(EmailTemplateStoreRequest $request) {
        $template = EmailTemplate::create( $request->validated() );

        return $this->setStatusCode( 201 )
            ->withItem( $template->fresh(), app( EmailTemplateTransformer::class ) );
    }

    /**
     * Varolan e-posta şablon bilgilerini günceller.
     *
     * @param EmailTemplateUpdateRequest $request
     * @param EmailTemplate $template
     *
     * @return mixed
     */
    public function update(EmailTemplateUpdateRequest $request, EmailTemplate $template) {
        $template->update( $request->validated() );

        return $this->noContent();
    }

    /**
     * Varolan bir e-posta şablonunu siler.
     *
     * @param EmailTemplate $template
     *
     * @return mixed
     * @throws \Exception
     */
    public function delete(EmailTemplate $template) {
        $this->authorize( 'destroy', $template );

        $template->delete();

        return $this->noContent();
    }

}