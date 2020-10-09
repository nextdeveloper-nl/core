<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Common\Services\NiN;


/**
 * Class NiN
 * @package PlusClouds\Core\Common\Services\NiN
 */
class NiN
{

    /**
     * @var array
     */
    private $endpoints = [
        'v1' => 'https://tckimlik.nvi.gov.tr/Service/KPSPublic.asmx?WSDL',
        'v2' => 'https://tckimlik.nvi.gov.tr/Service/KPSPublicYabanciDogrula.asmx?WSDL',
    ];

    /**
     * @var array
     */
    private $requiredFields = [
        [ 'nin', 'name', 'surname', 'year' ],
        [ 'nin', 'name', 'surname', 'day', 'month', 'year' ],
    ];

    /**
     * @param $fields
     * @param bool $citizen
     *
     * @return bool
     */
    public function verify($fields, $citizen = true) {
        $result = false;

        try {
            $this->checkRequiredFields( $fields, $citizen );

            $result = $citizen ? $this->citizen( $fields ) : $this->foreignCitizen( $fields );
        }
        catch( \InvalidArgumentException $e ) {

        }

        return $result;
    }

    /**
     * @param array $fields
     *
     * @return bool
     */
    private function citizen(array $fields) {
        $client = new \SoapClient( $this->endpoints['v1'], [ 'soap_version' => SOAP_1_2 ] );

        $response = $client->TCKimlikNoDogrula( [
            'TCKimlikNo' => $fields['nin'],
            'Ad'         => upperCaseTr( $fields['name'] ),
            'Soyad'      => upperCaseTr( $fields['surname'] ),
            'DogumYili'  => $fields['year'],
        ] );

        logger()->info('TCKimlik doğrulama sonucu: ' . print_r($response, true));

        return (bool) $response->TCKimlikNoDogrulaResult;
    }

    /**
     * @param array $fields
     *
     * @return bool
     */
    private function foreignCitizen(array $fields) {
        $client = new \SoapClient( $this->endpoints['v2'], [ 'soap_version' => SOAP_1_2 ] );

        $response = $client->YabanciKimlikNoDogrula( [
            'KimlikNo' => $fields['nin'],
            'Ad'       => upperCaseTr( $fields['name'] ),
            'Soyad'    => upperCaseTr( $fields['surname'] ),
            'DogumGun' => $fields['day'],
            'DogumAy'  => $fields['month'],
            'DogumYil' => $fields['year'],
        ] );

        return (bool) $response->YabanciKimlikNoDogrulaResult;
    }

    /**
     * @param $fields
     * @param $citizen
     *
     * @return bool
     */
    private function checkRequiredFields($fields, $citizen) {
        $keys = array_keys( $fields );

        $type = (int) ! $citizen;

        foreach( $this->requiredFields[ $type ] as $key ) {
            if( ! in_array( $key, $keys ) ) {
                throw new \InvalidArgumentException();
            }
        }

        return true;
    }

}