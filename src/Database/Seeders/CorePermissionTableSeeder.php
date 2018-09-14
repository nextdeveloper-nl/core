<?php
/**
 * This file is part of the PlusClouds.Account library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Seeders;

use Illuminate\Database\Seeder;
use PlusClouds\Account\Database\Models\Permission;
use PlusClouds\Account\Database\Models\Role;
use PlusClouds\Core\Database\Models\Category;
use PlusClouds\Core\Database\Models\Domain;

class CorePermissionTableSeeder extends Seeder
{

    public function run() {
        $domains = [
            [
                'name'      =>  'plusclouds.com',
                'account_id'    =>  5,
                'is_active' =>  true,
                'is_locked' =>  false
            ]
        ];

        $this->createDomains( $domains );

        $categories = [
            [
                'slug'          =>  'support',
                'category'      =>  'Support',
                'description'   =>  'This category contains elements about support.',
                'domain_id'     =>  1,
                'user_id'       =>  9,
                'children'  =>  [
                    [
                        'slug'          =>  'tickets',
                        'category'      =>  'Tickets',
                        'description'   =>  'This category contains support tickets.',
                        'domain_id'     =>  1,
                        'user_id'       =>  9,
                        'children'      =>  [
                            [
                                'slug'          =>  'paid',
                                'category'      =>  'Paid Tickets',
                                'description'   =>  'This category contains paid tickets.',
                                'domain_id'     =>  1,
                                'user_id'       =>  9,
                            ],
                            [
                                'slug'          =>  'free',
                                'category'      =>  'Free Tickets',
                                'description'   =>  'This category contains free tickets.',
                                'domain_id'     =>  1,
                                'user_id'       =>  9,
                            ],
                        ]
                    ]
                ]
            ],
            [
                'slug'          =>  'marketplace',
                'category'      =>  'Marketplace',
                'description'   =>  'This category contains products and services.',
                'domain_id'     =>  1,
                'user_id'       =>  9,
                'children'      =>  [
                    [
                        'slug'          =>  'content-management',
                        'category'      =>  'Content Management',
                        'description'   =>  'This category contains content management applications and services.',
                        'domain_id'     =>  1,
                        'user_id'       =>  9,
                    ],
                    [
                        'slug'          =>  'crm-erp-applications',
                        'category'      =>  'CRM & ERP Applications',
                        'description'   =>  'This category contains content ready to use CRM & ERP applications.',
                        'domain_id'     =>  1,
                        'user_id'       =>  9,
                    ],
                    [
                        'slug'          =>  'business-ads-management',
                        'category'      =>  'Business & Ads Management Applications',
                        'description'   =>  'This category contains Business & Ads management software.',
                        'domain_id'     =>  1,
                        'user_id'       =>  9,
                    ],
                    [
                        'slug'          =>  'backup-storage',
                        'category'      =>  'Backup & Storage Apps and Services',
                        'description'   =>  'This category contains applications and services for backup and storage purposes.',
                        'domain_id'     =>  1,
                        'user_id'       =>  9,
                    ],
                    [
                        'slug'          =>  'security-performance',
                        'category'      =>  'Security & Performance',
                        'description'   =>  'This category contains apps and services for security and performance.',
                        'domain_id'     =>  1,
                        'user_id'       =>  9,
                    ],
                    [
                        'slug'          =>  'voip-services',
                        'category'      =>  'VoIP Services',
                        'description'   =>  'This category contains services about voip.',
                        'domain_id'     =>  1,
                        'user_id'       =>  9,
                    ],
                    [
                        'slug'          =>  'devops-support-services',
                        'category'      =>  'DevOps & Support Services',
                        'description'   =>  'This category contains services about support and DevOps.',
                        'domain_id'     =>  1,
                        'user_id'       =>  9,
                    ],
                    [
                        'slug'          =>  'software-licences',
                        'category'      =>  'Software Licences',
                        'description'   =>  'This category contains licences.',
                        'domain_id'     =>  1,
                        'user_id'       =>  9,
                    ],
                ]
            ]
        ];

        $this->createCategories( $categories );

        $perms = [
            [ 'prefix' => 'core.domain', 'name' => 'list', 'label' => 'Domain List' ],
            [ 'prefix' => 'core.domain', 'name' => 'show', 'label' => 'Domain Show' ],
            [ 'prefix' => 'core.domain', 'name' => 'store', 'label' => 'Domain Create' ],
            [ 'prefix' => 'core.domain', 'name' => 'update', 'label' => 'Domain Update' ],
            [ 'prefix' => 'core.domain', 'name' => 'destroy', 'label' => 'Domain Destroy' ],

            [ 'prefix' => 'core.country', 'name' => 'list', 'label' => 'Country List' ],
            [ 'prefix' => 'core.country', 'name' => 'show', 'label' => 'Country Show' ],

            [ 'prefix' => 'core.discount', 'name' => 'list', 'label' => 'Discount List' ],
            [ 'prefix' => 'core.discount', 'name' => 'show', 'label' => 'Discount Show' ],

            [ 'prefix' => 'core.category', 'name' => 'list', 'label' => 'Category List' ],
            [ 'prefix' => 'core.category', 'name' => 'show', 'label' => 'Category Show' ],

            [ 'prefix' => 'core.hook', 'name' => 'list', 'label' => 'Hook List' ],
            [ 'prefix' => 'core.hook', 'name' => 'show', 'label' => 'Hook Show' ],
            [ 'prefix' => 'core.hook', 'name' => 'store', 'label' => 'Hook Create' ],
            [ 'prefix' => 'core.hook', 'name' => 'update', 'label' => 'Hook Update' ],
            [ 'prefix' => 'core.hook', 'name' => 'destroy', 'label' => 'Hook Destroy' ],
        ];

        $this->applyPermissions($perms, 'member');

        $perms = [
            [ 'prefix' => 'core.domain', 'name' => 'list', 'label' => 'Domain List' ],
            [ 'prefix' => 'core.domain', 'name' => 'show', 'label' => 'Domain Show' ],
            [ 'prefix' => 'core.domain', 'name' => 'store', 'label' => 'Domain Create' ],
            [ 'prefix' => 'core.domain', 'name' => 'update', 'label' => 'Domain Update' ],
            [ 'prefix' => 'core.domain', 'name' => 'destroy', 'label' => 'Domain Destroy' ],

            [ 'prefix' => 'core.country', 'name' => 'list', 'label' => 'Country List' ],
            [ 'prefix' => 'core.country', 'name' => 'show', 'label' => 'Country Show' ],
            [ 'prefix' => 'core.country', 'name' => 'store', 'label' => 'Country Create' ],
            [ 'prefix' => 'core.country', 'name' => 'update', 'label' => 'Country Update' ],
            [ 'prefix' => 'core.country', 'name' => 'destroy', 'label' => 'Country Destroy' ],

            [ 'prefix' => 'core.discount', 'name' => 'list', 'label' => 'Discount List' ],
            [ 'prefix' => 'core.discount', 'name' => 'show', 'label' => 'Discount Show' ],
            [ 'prefix' => 'core.discount', 'name' => 'store', 'label' => 'Discount Create' ],
            [ 'prefix' => 'core.discount', 'name' => 'update', 'label' => 'Discount Update' ],
            [ 'prefix' => 'core.discount', 'name' => 'destroy', 'label' => 'Discount Destroy' ],

            [ 'prefix' => 'core.category', 'name' => 'list', 'label' => 'Category List' ],
            [ 'prefix' => 'core.category', 'name' => 'show', 'label' => 'Category Show' ],
            [ 'prefix' => 'core.category', 'name' => 'store', 'label' => 'Category Create' ],
            [ 'prefix' => 'core.category', 'name' => 'update', 'label' => 'Category Update' ],
            [ 'prefix' => 'core.category', 'name' => 'destroy', 'label' => 'Category Destroy' ],

            [ 'prefix' => 'core.hook', 'name' => 'list', 'label' => 'Hook List' ],
            [ 'prefix' => 'core.hook', 'name' => 'show', 'label' => 'Hook Show' ],
            [ 'prefix' => 'core.hook', 'name' => 'store', 'label' => 'Hook Create' ],
            [ 'prefix' => 'core.hook', 'name' => 'update', 'label' => 'Hook Update' ],
            [ 'prefix' => 'core.hook', 'name' => 'destroy', 'label' => 'Hook Destroy' ],
        ];

        $this->applyPermissions($perms, 'super-admin');
        $this->applyPermissions($perms, 'admin');
    }

    private function applyPermissions( $perms, $role ) {
        for( $i = 0; $i < count($perms); $i++ ) {
            $permission = Permission::where( 'prefix', $perms[$i]['prefix'] )->where( 'name', $perms[$i]['name'] )->first();

            if( ! $permission ) {
                $permission = Permission::create( $perms[$i] );
            }

            Role::where('name', $role)->first()->permissions()->syncWithoutDetaching( $permission );
        }
    }

    private function createDomains($domains) {
        for( $i = 0; $i < count($domains); $i++ ) {
            $domain = Domain::where('name', 'like', $domains[$i]['name'])->first();

            if( ! $domain ) {
                $domain = Domain::create([
                    'name'      =>  'plusclouds.com',
                    'account_id'    =>  5,
                    'is_active' =>  true,
                    'is_locked' =>  false
                ]);
            }
        }
    }

    private function createCategories($categories, $parent = null) {
        for( $i = 0; $i < count($categories); $i++ ) {
            $category = Category::where('slug', 'like', $categories[$i]['slug'])->first();

            if( ! $category ) {
                $category = Category::create([
                    'name'      =>  $categories[$i]['category'],
                    'slug'      =>  $categories[$i]['slug'],
                    'description'   =>  $categories[$i]['description'],
                    'domain_id'     =>  $categories[$i]['domain_id'],
                    'user_id'   =>  $categories[$i]['user_id'],
                    'parent_id' =>  $parent
                ]);
            }

            if( array_key_exists('children', $categories[$i]) ) {
                $this->createCategories( $categories[$i]['children'], $category->id );
            }
        }

    }
}