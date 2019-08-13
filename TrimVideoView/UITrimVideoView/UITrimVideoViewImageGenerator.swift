//
//  UITrimVideoViewImageGenerator.swift
//  TrimVideoView
//
//  Created by eduardo fornari on 19/07/19.
//  Copyright © 2019 fornari. All rights reserved.
//

import UIKit
import AVFoundation

class UITrimVideoViewImageGenerator {

    private let avAssetImageGenerator: AVAssetImageGenerator
    private let cmTimeScale: CMTimeScale

    // MARK: - Init
    init(asset: AVAsset) {
        avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        avAssetImageGenerator.appliesPreferredTrackTransform = true
        avAssetImageGenerator.requestedTimeToleranceAfter = CMTime.zero
        avAssetImageGenerator.requestedTimeToleranceBefore = CMTime.zero
        cmTimeScale = asset.duration.timescale
    }

    // MARK: - Frame
    func frameSize() -> CGSize {
        if let image = generateFrame(for: 0) {
            return image.size
        }
        return CGSize(width: 100, height: 100)
    }

    func generateFrame(for time: Double) -> UIImage? {
        let cmTime: CMTime = CMTimeMakeWithSeconds(time,
                                                   preferredTimescale: cmTimeScale)
        if let cgImage = try? avAssetImageGenerator.copyCGImage(at: cmTime, actualTime: nil) {
            let image = UIImage(cgImage: cgImage)
            return image
        }
        return nil
    }

    func generateFrames(from times: [CMTime], _ completion: @escaping ([UIImage]?) -> Void) {
        let frameTimes = times.compactMap { (cmTime) -> NSValue? in
            return NSValue(time: cmTime)
        }
        if frameTimes.count != times.count {
            completion(nil)
        } else {
            var imagesWithTimes: [(CMTime, UIImage)] = []
            avAssetImageGenerator.generateCGImagesAsynchronously(
            forTimes: frameTimes) { (requestedTime, cgImage, _, _, _) in
                if let cgImage = cgImage {
                    let image = UIImage(cgImage: cgImage)
                    imagesWithTimes.append((requestedTime, image))
                    if imagesWithTimes.count == frameTimes.count {
                        let images = imagesWithTimes.sorted(by: { $0.0 < $1.0 })
                            .compactMap({ (imageWithTime) -> UIImage? in
                                return imageWithTime.1
                            })
                        completion(images)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }

}
