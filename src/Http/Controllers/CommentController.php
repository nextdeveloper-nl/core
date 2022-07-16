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

use PlusClouds\Core\Database\Models\Comment;
use PlusClouds\Core\Http\Requests\Comment\CommentListRequest;
use PlusClouds\Core\Http\Requests\Comment\CommentStoreRequest;
use PlusClouds\Core\Http\Requests\Comment\CommentUpdateRequest;

/**
 * Class CommentController.
 *
 * @package PlusClouds\Core\Http\Controllers
 */
class CommentController extends AbstractController
{

	/**
	 * @name Get a Comment List
	 *
	 * @param CommentListRequest $request
	 * @return \Illuminate\Http\JsonResponse
	 * @throws \PlusClouds\Core\Exceptions\ObjectNotFoundException
	 */
    public function index(CommentListRequest $request)
    {
        $data = $request->validated();

        $objectArr = findObjectFromClassName($data['object'], $data['object_id'], 'Commentable');

        $comments = Comment::where([['commentable_type',$objectArr[0]],['commentable_id',$objectArr[1]]])->get();


        return $this->withCollection($comments, app('PlusClouds\Core\Http\Transformers\CommentTransformer'));
    }

	/**
	 * @name Create a new Comment
	 *
	 * @param CommentStoreRequest $request
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 * @throws \PlusClouds\Core\Exceptions\ObjectNotFoundException
	 */
    public function store(CommentStoreRequest $request)
    {
        $data = $request->validated();
        $objectArr = findObjectFromClassName($data['object'], $data['object_id'], 'Commentable');

        Comment::create([
            'body' => $data['comment'],
            'user_id' => getAUUser()->id,
            'commentable_id' => $objectArr[1],
            'commentable_type' => $objectArr[0]
        ]);

        return $this->noContent();
    }

	/**
	 * @name Update a comment details
	 *
	 * @param CommentUpdateRequest $request
	 * @param Comment $comment
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 */
    public function update(CommentUpdateRequest $request, Comment $comment)
    {
        $comment->body = $request->validated()['comment'];
        $comment->save();

        return $this->noContent();
    }


	/**
	 * @name Deletes a Comment
	 *
	 * @param Comment $comment
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 */
    public function destroy(Comment $comment)
    {
        $comment->destroy();

        return $this->noContent();
    }
}
