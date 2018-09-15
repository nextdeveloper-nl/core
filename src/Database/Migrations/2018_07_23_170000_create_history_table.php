<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateHistoryTable extends Migration
{

    public function up() {
        Schema::create( 'history', function(Blueprint $table) {
            $table->bigIncrements( 'id' );
            $table->unsignedBigInteger( 'historyable_id' );
            $table->string( 'historyable_type' );
            $table->unsignedBigInteger( 'user_id' )->nullable();
            $table->longText( 'body' );
            $table->string( 'hash', 44 );
            $table->timestamps();
        } );
    }

    public function down() {
        Schema::dropIfExists( 'history' );
    }

}