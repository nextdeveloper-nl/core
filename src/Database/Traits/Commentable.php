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

use Illuminate\Database\Eloquent\Model;
use PlusClouds\Core\Database\Models\Comment;

/**
 * Trait Commentable
 * @package PlusClouds\Core\Database\Traits
 */
trait Commentable
{

    /**
     * Yorumları döndürür.
     *
     * @return mixed
     */
    public function comments() {
        return $this->morphMany( Comment::class, 'commentable' );
    }


    /**
     * Yeni bir yorum ekler.
     *
     * @param array $data
     * @param Model $creator
     * @param Model|null $ancestor
     *
     * @return bool
     */
    public function comment($data, Model $creator, Model $ancestor = null) {
        $comment = ( new Comment() )->createComment( $this, $data, $creator );

        if( ! empty( $ancestor ) ) {
            $ancestor->appendNode( $comment );
        }

        return $comment;
    }

    /**
     * Varolan bir yorumu günceller.
     *
     * @param int $id
     * @param array $data
     * @param Model|null $ancestor
     *
     * @return bool
     */
    public function updateComment($id, $data, Model $ancestor = null) {
        $comment = ( new Comment() )->updateComment( $id, $data );

        if( ! empty( $ancestor ) ) {
            $comment->appendToNode( $ancestor )->save();
        }

        return $comment;
    }

    /**
     * Varolan bir yorumu siler.
     *
     * @param int $id
     *
     * @return bool
     */
    public function deleteComment($id) {
        return (bool) ( new Comment() )->deleteComment( $id );
    }

    /**
     * Toplam yorum sayısını verir.
     *
     * @return mixed
     */
    public function commentCount() {
        return $this->comments->count();
    }

}