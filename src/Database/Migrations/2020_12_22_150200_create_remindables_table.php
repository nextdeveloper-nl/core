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
class CreateRemindablesTable extends Migration
{

    /**
     *
     */
    public function up() {
        Schema::create( 'remindables', function(Blueprint $table) {
        	$table->bigIncrements( 'id' );
	        $table->char('id_ref', 10)->charset('utf8')->collate('utf8_bin')->unique()->nullable();
            $table->unsignedBigInteger('remindable_id');
            $table->string('remindable_object_type');
            $table->datetime('remind_datetime')->nullable();
            $table->integer('user_id')->nullable();
            $table->text('note')->nullable();
            $table->booleaan('acknowledged')->default('false'); // okundu bilgisi
            $table->integer('status')->default('0')->comment('0 bekliyor,1 hatırlatıyor,2 görüldü,3 ertelendi bekliyor,4 iptal edildi');
            $table->timestamps();

            $table->softDeletes();

        } );

        DB::unprepared('
            CREATE TRIGGER before_remindables
              BEFORE INSERT ON remindables
              FOR EACH ROW
              SET new.id_ref = uuid();
        ');
    }

    /**
     *
     */
    public function down() {
        Schema::dropIfExists( 'reminables' );
    }
}