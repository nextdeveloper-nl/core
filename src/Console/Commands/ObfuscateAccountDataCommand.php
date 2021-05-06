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

use App;
use Faker\Generator as Faker;
use Illuminate\Console\Command;
use PlusClouds\Account\Database\Models\Account;
use PlusClouds\Account\Database\Models\User;

/**
 * Class ObfuscateAccountDataCommand.
 *
 * @package PlusClouds\Core\Console\Commands
 */
class ObfuscateAccountDataCommand extends Command {
    /**
     * @var string
     */
    protected $signature = 'plusclouds:obfuscate-accounts';

    /**
     * @var string
     */
    protected $description = 'Obfuscates PlusClouds Accounts';

    protected $faker;

    public function __construct(Faker $faker) {
        parent::__construct();

        $this->faker = $faker;
    }

    /**
     * @return int
     */
    public function handle() {
        if ( ! class_exists('\PlusClouds\Account\Database\Models\Account')) {
            $this->error('Account module not found!');

            return 0;
        }

        if ('local' != App::environment()) {
            $this->error('This process cannot be continued. Your environment setting is not correct. [Your Environment : '.App::environment().']');

            return 0;
        }

        $dispatcherAccount = Account::getEventDispatcher();

        if ( ! is_null($dispatcherAccount)) {
            Account::unsetEventDispatcher();
        }

        $dispatcherUser = Account::getEventDispatcher();

        if ( ! is_null($dispatcherUser)) {
            User::unsetEventDispatcher();
        }

        Account::withoutGlobalScopes()
            ->whereHas('members', function ($q) {
                $q->where('email', 'not like', '\'%plusclouds.com%\'');
            })
            ->whereNull('domain')
            ->chunk(500, function ($accounts) {
                foreach ($accounts as $account) {
                    $originalAccountName = $account->name;
                    $name = $this->faker->name;
                    $surname = $this->faker->lastname;
                    $fullname = $name.' '.$surname;

                    $account->forceFill([
                        'name'   => $fullname,
                        'iam_dn' => null,
                        'phone'  => null,
                    ])->save();

                    $this->line($originalAccountName.' / '.$account->name);

                    $members = $account->members;

                    if ($members->count() > 0) {
                        foreach ($members as $member) {
                            $originalFullName = $member->fullname;

                            $member->forceFill([
                                'name'       => $name,
                                'surname'    => $surname,
                                'fullname'   => $fullname,
                                'email'      => $this->faker->unique()->safeEmail,
                                'password'   => str_random(10),
                                'username'   => null,
                                'nin'        => null,
                                'cell_phone' => null,
                                'iam_dn'     => null,
                            ])->save();

                            $this->line('--- '.$originalFullName.' / '.$member->fullname.' / '.$member->email);
                        }
                    }
                }
            });

        return 1;
    }
}
