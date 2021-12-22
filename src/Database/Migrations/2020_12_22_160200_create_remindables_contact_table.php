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
class CreateRemindableContactsTable extends Migration
{

    /**
     *
     */
    public function up() {
        Schema::create( 'remindables_contacts', function(Blueprint $table) {

            $table->unsignedBigInteger('remindable_id');

            $table->unsignedBigInteger('contact_id');

            $table->timestamps();

            $table->foreign('contact_id')->references('id')->on('contacts');
        } );
    }

    /**
     *
     */
    public function down() {
        Schema::dropIfExists( 'remindable_contacts' );
    }
}