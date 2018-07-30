<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Transformers\Traits;


use Illuminate\Database\Eloquent\Model;
use League\Fractal\ParamBag;
use PlusClouds\Core\Http\Transformers\AttachmentTransformer;

/**
 * Trait AttachmentTransformerTrait
 * @package PlusClouds\Core\Http\Transformers\Traits
 */
trait AttachmentTransformerTrait
{

    /**
     * @param Model $model
     * @param ParamBag|null $params
     *
     * @return mixed
     * @throws \Exception
     */
    public function includeAttachments(Model $model, ParamBag $params = null) {
        if( $params != null ) {
            list( $type ) = $params->get( 'type' );

            $type = $type ?? '';
        }

        return $this->collection( $model->getMedia( $type ), new AttachmentTransformer() );
    }

}