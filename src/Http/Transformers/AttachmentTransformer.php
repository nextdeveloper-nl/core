<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Transformers;


use Spatie\MediaLibrary\Media;

/**
 * Class AttachmentTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class AttachmentTransformer extends AbstractTransformer
{

    /**
     * @var array
     */
    protected $visible = [ 'id', 'name', 'size', 'url', 'manipulations', 'properties' ];

    /**
     * @param Media $media
     *
     * @return array
     */
    public function transform(Media $media) {
        return $this->buildPayload( [
            'id'            => $media->id,
            'original_name' => $media->name,
            'name'          => $media->file_name,
            'size'          => $media->size,
            'url'           => $media->getUrl(),
            'manipulations' => $media->manipulations,
            'properties'    => $media->custom_properties,
            'created_at'    => $media->created_at->toIso8601String(),
            'updated_at'      => $this->when( ! is_null( $media->updated_at ), optional( $media->updated_at )->toIso8601String() ),
        ] );
    }

}