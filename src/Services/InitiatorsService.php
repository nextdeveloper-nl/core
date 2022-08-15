<?php

namespace PlusClouds\Core\Services;

use Illuminate\Support\Facades\Storage;
use PlusClouds\Core\Exceptions\InitiatorNotExistsException;

class InitiatorsService
{
    public static function getInitiators($moduleName)
    {
        $moduleFolder = base_path('vendor/plusclouds/' . $moduleName . '/src/Initiators/');

        $allFiles = InitiatorsService::getDirContentsAsArray($moduleFolder);

        return $allFiles;
    }

    public static function executeInitiator($moduleName, $initiator)
    {
        $moduleFolder = base_path('vendor/plusclouds/' . $moduleName . '/src/Initiators/');

        $filename = $moduleFolder . $initiator . '.php';

        throw_if(!file_exists($filename), InitiatorNotExistsException::class, 'Initiator do not exists.');

        switch ($moduleName) {
            case 'iaas':
                $moduleName = 'IAAS';
                break;
            case 'crm':
                $moduleName = 'CRM';
                break;
            default:
                $moduleName = ucwordsTr($moduleName);
                break;
        }

        $class = '\\PlusClouds\\' . $moduleName . '\\Initiators\\' . str_replace('/', '\\', $initiator);

        throw_if(!class_exists($class), InitiatorNotExistsException::class, 'Initiator exists as a file but cannot find it as a class.');

        $class = new $class();

        dispatch($class);

        return true;
    }

    public static function getDirContentsAsArray($dir)
    {
        $contents = self::getDirContents($dir);

        $tempContents = [];

        foreach ($contents as $content) {
            if ('php' != pathinfo($content, PATHINFO_EXTENSION)) {
                continue;
            }

            $initiatorsFolderPos = strpos($content, 'Initiators');
            $initiator = substr($content, $initiatorsFolderPos);
            $initiator = str_replace('.php', '', $initiator);
            $tempContents[] = str_replace('Initiators/', '', $initiator);
        }

        $contents = $tempContents;

        return $contents;
    }

    public static function getDirContents($dir, &$results = array())
    {
        $files = scandir($dir);

        foreach ($files as $key => $value) {
            $path = realpath($dir . DIRECTORY_SEPARATOR . $value);
            if (!is_dir($path)) {
                $results[] = $path;
            } elseif ($value != "." && $value != "..") {
                self::getDirContents($path, $results);
                $results[] = $path;
            }
        }

        return $results;
    }
}
