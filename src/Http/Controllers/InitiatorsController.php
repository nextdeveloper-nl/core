<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Http\Controllers;

use Illuminate\Support\Facades\Storage;
use PlusClouds\Core\Database\Models\Address;
use PlusClouds\Core\Database\Models\Country;
use PlusClouds\Core\Http\Requests\Address\AddressStoreRequest;
use PlusClouds\Core\Http\Requests\Address\AddressUpdateRequest;
use PlusClouds\Core\Http\Requests\Initiators\InitiatorExecutionRequest;
use PlusClouds\Core\Services\InitiatorsService;

/**
 * Class AddressController
 * @package PlusClouds\Core\Http\Controllers
 */
class InitiatorsController extends AbstractController
{
	/**
	 * Lists all the initiators in a module
	 *
	 * @param AddressStoreRequest $request
	 * @return \Illuminate\Contracts\Routing\ResponseFactory|\Symfony\Component\HttpFoundation\Response
	 * @throws \PlusClouds\Core\Exceptions\ObjectNotFoundException
	 */
    public function index($moduleName)
    {
		if(getAUCurrentAccount() == null) {
			return $this->errorUnprocessable('Cannot execute this command. You dont have privileges.');
		}

		if(!getAUUser()->hasRole('admin, super-admin')) {
			return $this->errorUnprocessable('Cannot execute this command, you need to be admin or super admin to do this.');
		}

	    if(!moduleExists($moduleName)) {
			return $this->errorUnprocessable('There is no such module called: ' . $moduleName);
	    }

	    return $this->withArray(InitiatorsService::getInitiators($moduleName));

        return $this->setStatusCode(202)->noContent();
    }

	public function execute(InitiatorExecutionRequest $request) {
        try {
            $result = InitiatorsService::executeInitiator($request->get('module_name'), $request->get('initiator'));
        } catch (\Exception $e) {
            throw $e;
        }
	}
}
