<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Transformers;

use PlusClouds\Core\Database\Models\Remindable;

/**
 * Class VoteTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class RemindableTransformer extends AbstractTransformer
{

    /**
     * @param Vote $vote
     *
     * @return array
     */
    public function transform($reminable)
    {
        $array = explode("\\", $reminable->remindable_object_type);

        switch ($reminable->status){
            case 0:
                $status = 'Bekliyor';
                break;
            case 1:
                $status = 'Hatırlatıyor';
                break;
            case 2:
                $status = 'Görüldü';
                break;
            case 3:
                $status = 'Ertelendi Bekliyor';
                break;
            case 4:
                $status = 'İptal Edildi';
                break;
            default:
                $status = 'Bilinmeyen Statü';
                break;
        }

        return $this->buildPayload([
            'id'                      => $reminable->id_ref,
            'remind_datetime'         => $reminable->remind_datetime,
            'remindable_object_type'  => lowerCaseTr(end($array)),
            'remindable_object_id'    => $reminable->reminable->id_ref,
            'note'                    => $reminable->note,
            'status'                  => $status
        ]);
    }
}
