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
use PlusClouds\Core\Common\Enums\TagType;
use PlusClouds\Core\Database\Models\Tag;
use PlusClouds\Core\Events\TagWasAttached;
use PlusClouds\Core\Events\TagWasDetached;

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
     * @param null|string $type
     *
     * @return $this
     */
    public function tag($tags, $type = null) {
        $tags = normalizeTag( $tags );

        foreach( $tags as $label ) {
            $args = [
                'name' => $label,
            ];

            //  Eğer ilgili tag sistem tag'i olarak veritabanında varsa relation'ı kur sonraki tag'e geç
            if( $tag = Tag::where( 'name', $label )
                ->where( 'type', TagType::SYSTEM )
                ->first() ) {

                $this->tags()->syncWithoutDetaching( $tag->getKey() );

                event( new TagWasAttached( $this, $tag ) );

                continue;
            }

            //  Eğer ilgili tag application veya user tag'i olarak veritabanında varsa relation'ı kur sonraki tag'e geç
            if( $tag = Tag::where( 'name', $label )
                ->where( 'account_id', getAUCurrentAccount()->id )
                ->first() ) {

                $this->tags()->syncWithoutDetaching( $tag->getKey() );

                event( new TagWasAttached( $this, $tag ) );

                continue;
            }

            //  Eğer ilgili tag veritabanında yoksa relation'ı kur sonraki tag'e geç
            $type = ( $type ) ? $type : TagType::USER;

            $tag = Tag::create( array_merge( $args, [
                'type'       => $type,
                'account_id' => getAUCurrentAccount()->id,
            ] ) );

            $this->tags()->attach( $tag->getKey() );

            event( new TagWasAttached( $this, $tag ) );
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
            Tag::where( 'slug', $slug )
                ->where( function($q) {
                    $q->when( isLoggedIn(), function($q) {
                        $q->where( 'account_id', getAUCurrentAccount()->id )
                            ->orWhereNull( 'account_id' );
                    } );
                } )
                ->get()
                ->each( function($tag) {
                    $this->tags()->detach( $tag->id );

                    event( new TagWasDetached( $this, $tag ) );
                } );
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