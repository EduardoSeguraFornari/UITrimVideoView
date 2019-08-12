//
//  VideoHelper.swift
//
//  Copyright © 2018 Fornari. All rights reserved.
//

import MobileCoreServices
import Photos
import MediaPlayer

class VideoHelper {

    static func startMediaBrowser(
        delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate,
        sourceType: UIImagePickerController.SourceType) {

        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }

        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = delegate
        if #available(iOS 11.0, *) {
            imagePickerController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        }
        delegate.present(imagePickerController, animated: true)
    }

}
