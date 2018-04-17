<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Models;

use Illuminate\Database\Eloquent\SoftDeletes;
use PlusClouds\Core\Database\Traits\HashId;
use Kalnoy\Nestedset\NodeTrait;

/**
 * Class Comment
 * @package PlusClouds\Core\Database\Models
 */
class Comment extends AbstractModel
{

    use SoftDeletes, HashId, NodeTrait;

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphTo
     */
    public function commentable() {
        return $this->morphTo();
    }

    /**
     * @return bool
     */
    public function hasChildiren() {
        return $this->children()->count() > 0;
    }

    /**
     * Yeni bir yorum ekler.
     *
     * @param $commentable
     * @param array $data
     * @param $creator
     *
     * @return mixed
     */
    public function createComment($commentable, $data, $creator) {
        $comment = new static();
        $comment->forceFill( array_merge( $data, [
            'user_id' => $creator->id,
        ] ) );

        return $commentable->comments()->save( $comment );
    }

    /**
     * Varolan bir yorumu günceller.
     *
     * @param int $id
     * @param array $data
     *
     * @return bool
     */
    public function updateComment($id, $data) {
        return (bool) static::find( $id )->forceFill( $data )->save();
    }

    /** Varolan bir yorumu siler.
     *
     * @param int $id
     *
     * @return bool
     */
    public function deleteComment($id) {
        return (bool) static::find( $id )->delete();
    }

}