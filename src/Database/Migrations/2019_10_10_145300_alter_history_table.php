<?php
/**
 * This file is part of the PlusClouds.IAAS library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterHistoryTable extends Migration
{

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up() {
        if( Schema::hasTable( 'history' ) ) {
            Schema::table( 'history', function(Blueprint $table) {
                $table->index( [ 'historyable_id', 'historyable_type' ] );
            } );
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down() {
        
    }

}