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

/**
 * Class AlterTagsTable
 */
class AlterTagsTable extends Migration
{

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up() {
        if( Schema::hasTable( 'tags' ) ) {
            Schema::table( 'tags', function(Blueprint $table) {
                $table->enum( 'type', [ 'system', 'common', 'application' ] )->default( 'system' )->after( 'slug' );
                $table->unsignedBigInteger( 'account_id' )->nullable()->after( 'type' );

                $table->foreign( 'account_id' )
                    ->references( 'id' )
                    ->on( 'accounts' )
                    ->onDelete( 'set null' );
            } );
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down() {
        //
    }

}