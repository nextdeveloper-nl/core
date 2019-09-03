<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Events;


use Illuminate\Database\Eloquent\Model;
use PlusClouds\Core\Database\Models\Tag;

/**
 * Class TagWasDetached
 * @package PlusClouds\Core\Events
 */
class TagWasDetached extends AbstractEvent
{

    /**
     * @var Model
     */
    public $model;

    /**
     * @var Tag
     */
    public $tag;

    /**
     * TagWasDetached constructor.
     *
     * @param Model $model
     * @param Tag $tag
     */
    public function __construct(Model $model, Tag $tag) {
        $this->model = $model;
        $this->tag = $tag;
    }

}