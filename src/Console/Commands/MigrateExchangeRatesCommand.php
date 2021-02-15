<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use PlusClouds\Core\Database\Models\ExchangeRate;
use PlusClouds\Core\Database\Models\v1\Tcmb;

/**
 * Class MigrateExchangeRatesCommand.
 *
 * @package PlusClouds\Core\Console\Commands
 */
class MigrateExchangeRatesCommand extends Command {
    /**
     * @var string
     */
    protected $signature = 'plusclouds:migrate-exchange-rates';

    /**
     * @var string
     */
    protected $description = 'PlusClouds Migrate Exchange Rates';

    /**
     * @return int
     */
    public function handle() {
        if ( ! ($id = $this->last())) {
            $this->warn('Migrate edilecek kayıt bulunamadı.');

            return;
        }

        DB::statement('SET FOREIGN_KEY_CHECKS=0;');

        Tcmb::where('id', '>=', $id)
            ->orderBy('id', 'ASC')
            ->chunk(10000, function ($exchangeRates) {
                $progress = $this->output->createProgressBar($exchangeRates->count());
                $progress->setFormat("%current%/%max% [%bar%] %percent:3s%% \n%message%\n");

                foreach ($exchangeRates as $rate) {
                    $oldId = $rate->id;
                    $data = collect()->make(unserialize($rate->data));
                    $lastModified = Carbon::createFromFormat('Y-m-d H:i:s', date('Y-m-d H:i:s', $rate->last_modified), 'GMT');
                    $lastModified->setTimezone(env('APP_TIMEZONE'));

                    $progress->setMessage(sprintf('<info>Exchange Rate : %d</info>', $rate->id));

                    $data->each(function ($value, $code) use ($oldId, $lastModified) {
                        ExchangeRate::create([
                            'old_id'        => $oldId,
                            'code'          => $code,
                            'rate'          => $value,
                            'last_modified' => $lastModified,
                        ]);
                    });

                    $progress->advance();
                }

                $progress->finish();
            });

        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        return 1;
    }

    /**
     * @return mixed
     */
    private function last() {
        if ( ! ($current = ExchangeRate::latest('old_id')->first())) {
            return Tcmb::orderBy('id', 'ASC')->first()->id;
        }

        return optional(
            Tcmb::where('id', '>', $current->old_id)
                ->orderBy('id', 'ASC')
                ->first()
        )->id;
    }
}
