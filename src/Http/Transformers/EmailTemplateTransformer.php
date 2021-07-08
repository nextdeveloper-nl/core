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

use PharIo\Manifest\Email;
use PlusClouds\Core\Database\Models\EmailTemplate;

/**
 * Class EmailTemplateTransformer
 * @package PlusClouds\Core\Http\Transformers
 */
class EmailTemplateTransformer extends AbstractTransformer
{

    /**
     * @param EmailTemplate $template
     *
     * @return array
     */
    public function transform(EmailTemplate $template)
    {
    	//  @todo: Burası daha sonra database'den gelmeli

    	$locales = config('core.locales.availables');

	    $availableLocales = [];
	    $unavailableLocales = [];

    	foreach ($locales as $locale) {
    		if($template->locale == $locale) {
			    $availableLocales[] = $locale;
			    continue;
		    }

    		$emailTemplate = EmailTemplate::where('name', $template->name)->where('locale', $locale)->first();

    		if($emailTemplate)
    			$availableLocales[] = $locale;
    		else
    			$unavailableLocales[] = $locale;
	    }

        return $this->buildPayload([
            'id'          => $template->id_ref,
            'name'        => $template->name,
            'description' => $template->description,
            'body'        => $template->body,
            'subject'     => $template->subject,
            'locale'      => $template->locale,
	        'available_locales'  =>  $availableLocales,
	        'unavailable_locales'   =>  $unavailableLocales
        ]);
    }
}
