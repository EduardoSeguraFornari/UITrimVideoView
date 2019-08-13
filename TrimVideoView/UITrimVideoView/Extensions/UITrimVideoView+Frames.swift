//
//  UITrimVideoView+Frames.swift
//  TrimVideoView
//
//  Created by Eduardo Fornari on 13/08/19.
//  Copyright © 2019 Eduardo Fornari. All rights reserved.
//

import UIKit
import AVFoundation

extension UITrimVideoView {

    internal func setFrames(for asset: AVAsset) {
        let trimVideoViewImageGenerator = UITrimVideoViewImageGenerator(asset: asset)

        let videoFrameSize = trimVideoViewImageGenerator.frameSize()
        let totalSize = framesView.frame.size
        let thumbnailScale = totalSize.height / videoFrameSize.height
        let idealSize = CGSize(width: thumbnailScale * videoFrameSize.width,
                               height: thumbnailScale * videoFrameSize.height)

        let numberOfFrames = Int(totalSize.width / idealSize.width)

        let thumbnailWidth = totalSize.width / CGFloat(numberOfFrames)
        let thumbnailSize = CGSize(width: thumbnailWidth, height: totalSize.height)

        let timeOffset = asset.duration.seconds / Double(numberOfFrames)
        var timeFrame: Float64 = 0
        var times: [CMTime] = []
        for _ in 0..<numberOfFrames {
            let cmTime: CMTime = CMTimeMakeWithSeconds(timeFrame,
                                                       preferredTimescale: asset.duration.timescale)
            times.append(cmTime)
            timeFrame += timeOffset
        }

        var offset: CGFloat = 0
        trimVideoViewImageGenerator.generateFrames(from: times, { images in
            if let images = images {
                for image in images {
                    self.placeFrame(image: image, with: offset, and: thumbnailSize)
                    offset += thumbnailSize.width
                }
            }
        })
    }

    private func placeFrame(image: UIImage, with offset: CGFloat, and size: CGSize) {
        DispatchQueue.main.async {
            let frame = CGRect(origin: CGPoint(x: offset, y: 0), size: size)
            let thumbnail = UIImageView(frame: frame)
            thumbnail.image = image
            self.framesView.addSubview(thumbnail)
        }
    }

}
