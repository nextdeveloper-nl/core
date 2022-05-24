<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * Class CreateStatesTable
 */
class CreateServiceRolesTable extends Migration
{
    public function up()
    {
        Schema::create('service_roles', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->boolean('has_update')->nullable();
            $table->unsignedBigInteger('object_id');
            $table->string('object_type');
            $table->timestamps();
        });
    }
}
