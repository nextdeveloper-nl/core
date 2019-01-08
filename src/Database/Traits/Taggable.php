<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;

use Illuminate\Database\Eloquent\Builder;
use PlusClouds\Core\Database\Models\Tag;

/**
 * Trait Taggable
 * @package PlusClouds\Core\Database\Traits
 */
trait Taggable
{

    /**
     * Model'e ait etiketleri döndürür.
     *
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function tags() {
        return $this->morphToMany( Tag::class, 'taggable' )
            ->withTimestamps();
    }

    /**
     * Model'e bir veya birden fazla etkiet ekler.
     *
     * @param string|array $tags
     *
     * @return $this
     */
    public function tag($tags) {
        $tags = normalizeTag( $tags );

        foreach( $tags as $label ) {
            $tag = Tag::firstOrCreate( [
                'name' => $label,
            ] );

            if( ! $this->tags->contains( $tag->getKey() ) ) {
                $this->tags()->attach( $tag->getKey() );
            }
        }

        return $this->load( 'tags' );
    }

    /**
     * Modelde bulunan etiketi çıkarır.
     *
     * @param string|array $tags
     *
     * @return $this
     */
    public function untag($tags) {
        $slugs = $this->makeSlugs( $tags );

        foreach( $slugs as $slug ) {
            if( $tag = Tag::where( 'slug', $slug )->first() ) {
                $this->tags()->detach( $tag->id );
            }
        }

        return $this->load( 'tags' );
    }

    /**
     * Model için etkiet ilişkilerinin tamamını siler.
     *
     * @return $this
     */
    public function detag() {
        $this->tags()->sync( [] );

        return $this->load( 'tags' );
    }

    /**
     * Model için etiketlerin tamanını siler, yenilerini ekler.
     *
     * @param string|array $tags
     *
     * @return $this
     */
    public function retag($tags) {
        return $this->detag()->tag( $tags );
    }

    /**
     * Verilen etiketlere göre sonuçları döndürür.
     *
     * @param Builder $builder
     * @param $tags
     *
     * @return mixed
     */
    public function scopeWithAllTags(Builder $builder, $tags) {
        $slugs = $this->makeSlugs( $tags );

        return $builder->whereHas( 'tags', function($q) use ($slugs) {
            $q->whereIn( 'slug', $slugs );
        }, '=', count( $slugs ) );
    }

    /**
     * Verilen etiketlere uygun sonuçları döndürür.
     *
     * @param Builder $builder
     * @param array $tags
     *
     * @return mixed
     */
    public function scopeWithAnyTags(Builder $builder, $tags = []) {
        $slugs = $this->makeSlugs( $tags );

        if( empty( $slugs ) ) {
            return $builder->has( 'tags' );
        }

        return $builder->whereHas( 'tags', function($q) use ($slugs) {
            $q->whereIn( 'slug', $slugs );
        } );
    }

    /**
     * @param string|array $tags
     *
     * @return array
     */
    protected function makeSlugs($tags) {
        return array_map( 'slugify', buildTagArray( $tags ) );
    }

}