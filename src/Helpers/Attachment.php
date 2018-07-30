<?php
/**
 * This file is part of the PlusClouds.Core library.
 *
 * (c) Semih Turna <semih.turna@plusclouds.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use Symfony\Component\HttpFoundation\File\UploadedFile;

/**
 * @param UploadedFile $file
 *
 * @return array|bool
 */
function getStorageAndCollectionNameFromAttachmentFile(UploadedFile $file) {
    switch( $file->getMimeType() ) {
        case 'image/png' :
        case 'image/jpeg' :
        case 'image/jpg' :
        case 'image/gif' :
            return [ 'images', 'media' ];
        case 'application/pdf' :
        case 'application/msword' :
        case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' :
        case 'application/vnd.oasis.opendocument.text' :
        case 'application/vnd.ms-excel' :
        case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' :
        case 'application/vnd.oasis.opendocument.spreadsheet' :
            return [ 'files', 'docs' ];
        case 'application/x-rar-compressed' :
        case 'application/zip' :
        case 'application/x-tar' :
            return [ 'files', 'files' ];
    }

    return false;
}

/**
 * @param UploadedFile $file
 *
 * @return string
 */
function getNewFileName(UploadedFile $file) {
    return sha1( $file->getClientOriginalName().time() ).'.'.$file->getClientOriginalExtension();
}