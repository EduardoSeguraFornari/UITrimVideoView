//
//  ViewController.swift
//  TrimVideoView
//
//  Created by Eduardo Fornari on 12/08/19.
//  Copyright © 2019 Eduardo Fornari. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBAction func selectVideoButtonDidTap(_ sender: Any) {
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TrimVideoViewController.identifier {
            if let asset = sender as? AVAsset {
                if let destination = segue.destination as? TrimVideoViewController {
                    destination.asset = asset
                }
            }
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate { }

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        dismiss(animated: true) {
            if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                let asset = AVAsset(url: url)
                self.performSegue(withIdentifier: TrimVideoViewController.identifier, sender: asset)
            }
        }

    }

}
