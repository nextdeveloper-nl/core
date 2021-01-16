<?php
/**
 * This file is part of the PlusClouds.IAAS library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PlusClouds\Core\Database\Traits;

/**
 * Trait Configable.
 *
 * @package PlusClouds\Core\Database\Traits
 */
trait Configable {
    use Meta;

    /**
     * @return mixed
     */
    public function getAllConfig() {
        $configs = json_decode(json_encode($this->getMeta('config')), true) ?? [];

        if (isset($this->defaultConfig)) {
            $configs = array_merge($this->defaultConfig::getDefaults(), $configs);
        }

        return $configs;
    }

    /**
     * @param mixed $key
     * @param bool  $excludeDefaultConfigs
     *
     * @return bool
     */
    public function hasConfig($key, $excludeDefaultConfigs = false) {
        if ( ! $this->hasMeta('config.'.$key) && ! $excludeDefaultConfigs) {
            if ( ! isset($this->defaultConfig)) {
                return false;
            }

            if ( ! array_key_exists($key, $this->defaultConfig::getDefaults())) {
                return false;
            }
        }

        return true;
    }

    /**
     * @param $key
     * @param null $default
     * @param bool $getObj
     *
     * @return null|\Illuminate\Support\Collection|mixed
     */
    public function getConfig($key, $default = null, $getObj = false) {
        $config = $this->getMeta('config.'.$key, $default, $getObj);

        if ($config instanceof \stdClass) {
            $config = json_decode(json_encode($config), true);
        }

        if (is_null($config) && isset($this->defaultConfig)) {
            $config = array_get($this->defaultConfig::getDefaults(), $key);
        }

        return $config;
    }

    /**
     * @param $key
     * @param bool $value
     *
     * @return mixed
     */
    public function deleteConfig($key, $value = false) {
        return $this->deleteMeta('config.'.$key, $value);
    }

    /**
     * @param $key
     * @param $value
     *
     * @return bool|mixed
     */
    public function addConfig($key, $value) {
        if ( ! $this->hasMeta('config')) {
            $this->addMeta('config', []);
        }

        $config = array_merge((array)$this->getMeta('config'), [
            $key => $value,
        ]);

        return $this->updateMeta('config', $config);
    }

    /**
     * @param $key
     * @param $newValue
     * @param bool $oldValue
     *
     * @return null|mixed
     */
    public function updateConfig($key, $newValue, $oldValue = false) {
        return $this->updateMeta('config.'.$key, $newValue, $oldValue);
    }

    /**
     * @param $key
     * @param $value
     *
     * @return mixed
     */
    public function appendConfig($key, $value) {
        return $this->appendMeta('config.'.$key, $value);
    }
}
