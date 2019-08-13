//
//  TrimVideoViewController.swift
//  TrimVideoView
//
//  Created by Eduardo Fornari on 12/08/19.
//  Copyright © 2019 Eduardo Fornari. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - UITrimVideoViewDelegate
protocol UITrimVideoViewDelegate: class {
    func didChangeValue(videoRangeSlider: UITrimVideoView, startTime: Double)
    func didChangeValue(videoRangeSlider: UITrimVideoView, endTime: Double)
}

class TrimVideoViewController: UIViewController {

    static let identifier = String(describing: TrimVideoViewController.self)

    var asset: AVAsset?

    private var trimVideoViewImageGenerator: UITrimVideoViewImageGenerator?

    @IBOutlet private weak var coverImageView: UIImageView!

    @IBOutlet private weak var startLabel: UILabel!
    @IBOutlet private weak var endLabel: UILabel!

    @IBOutlet weak var trimVideoView: UITrimVideoView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let asset = asset {
            trimVideoViewImageGenerator = UITrimVideoViewImageGenerator(asset: asset)
            coverImageView.image = trimVideoViewImageGenerator?.generateFrame(for: 0)
            startLabel.text = Double(0).formatedAsTime
            endLabel.text = asset.duration.seconds.formatedAsTime
            trimVideoView.delegate = self
            trimVideoView.set(asset: asset)
        } else {
            dismiss(animated: true)
        }

    }

}

// MARK: - UITrimVideoViewDelegate
extension TrimVideoViewController: UITrimVideoViewDelegate {
    func didChangeValue(videoRangeSlider: UITrimVideoView, startTime: Double) {
        startLabel.text = startTime.formatedAsTime
        coverImageView.image = trimVideoViewImageGenerator?.generateFrame(for: startTime)
    }

    func didChangeValue(videoRangeSlider: UITrimVideoView, endTime: Double) {
        endLabel.text = endTime.formatedAsTime
        coverImageView.image = trimVideoViewImageGenerator?.generateFrame(for: endTime)
    }
}
