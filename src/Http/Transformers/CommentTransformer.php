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


use League\Fractal\ParamBag;
use PlusClouds\Account\Database\Models\User;
use PlusClouds\Account\Http\Transformers\UserTransformer;
use PlusClouds\Core\Database\Models\Comment;

/**
 * Class CommentTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class CommentTransformer extends AbstractTransformer
{

    /**
     * @var array
     */
    protected $visible = [ 'id', 'body', 'lft', 'rgt', 'created_at' ];

    /**
     * @var array
     */
    protected $availableIncludes = [ 'creator' ];

    /**
     * @param Comment $comment
     *
     * @return array
     */
    public function transform(Comment $comment) {
        $payload = [
            'id'         => $comment->id_ref,
            'body'       => $comment->body,
            'created_at' => $comment->created_at->toIso8601String(),
            'updated_at' => $this->when( ! is_null( $comment->updated_at ), optional( $comment->updated_at )->toIso8601String() ),
        ];

        if( $comment->user_id == getAUUser()->id ) {
            $payload['can_edit'] = true;
        }

        if( ! $comment->children->isEmpty() ) {
            foreach( $comment->children as $key => $value ) {
                $payload['children'][] = $this->transform( $value );
            }

            return $payload;
        }

        return $this->buildPayload( $payload );
    }

    public function includeCreator(Comment $comment, ParamBag $paramBag = null) {
        return $this->item( $comment->creator, new UserTransformer( $paramBag ) );
    }
}