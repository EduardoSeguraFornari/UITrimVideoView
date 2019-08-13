//
//  UITrimVideoView+GestureRecognizers.swift
//  TrimVideoView
//
//  Created by Eduardo Fornari on 13/08/19.
//  Copyright © 2019 Eduardo Fornari. All rights reserved.
//

import UIKit

// MARK: - Gesture Recognizers
extension UITrimVideoView {

    internal func addGestureRecognizers() {
        let thumbLeftAction = #selector(thumbLeftGestureRecognizer(_:))
        let thumbLeftPanGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                                   action: thumbLeftAction)
        thumbLeft.addGestureRecognizer(thumbLeftPanGestureRecognizer)

        let thumbRightAction = #selector(thumbRightGestureRecognizer(_:))
        let thumbRightPanGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                                    action: thumbRightAction)
        thumbRight.addGestureRecognizer(thumbRightPanGestureRecognizer)
    }

    @objc private func thumbLeftGestureRecognizer(_ gesture: UIPanGestureRecognizer) {
        DispatchQueue.main.async {
            let touchLocation = gesture.location(in: self)
            self.updateThumbLeft(with: touchLocation)
        }
    }

    private func updateThumbLeft(with touchLocation: CGPoint) {
        guard let thumbRightConstraint = thumbRightConstraint?.constant else { return }
        let thumbRightPosition = abs(thumbRightConstraint) + thumbWidth

        let totalWidth = self.contentView.frame.width
        let halfThumbWidth = self.thumbWidth * 0.5
        let newMargin = touchLocation.x - halfThumbWidth

        if newMargin < 0 {
            thumbLeftConstraint?.constant = 0
        } else if (newMargin + thumbWidth) + thumbRightPosition < totalWidth - 1 {
            thumbLeftConstraint?.constant = newMargin
        } else {
            thumbLeftConstraint?.constant = totalWidth - thumbRightPosition - thumbWidth - 1
        }
        startTime = calculateStartTime()
        delegate?.didChangeValue(videoRangeSlider: self, startTime: startTime)
    }

    @objc private func thumbRightGestureRecognizer(_ gesture: UIPanGestureRecognizer) {
        DispatchQueue.main.async {
            let touchLocation = gesture.location(in: self)
            self.updateThumbRight(with: touchLocation)
        }
    }

    private func updateThumbRight(with touchLocation: CGPoint) {
        guard let thumbLeftConstraint = thumbLeftConstraint?.constant else { return }
        let thumbLeftPosition = thumbLeftConstraint + thumbWidth

        let totalWidth = self.contentView.frame.width
        let halfThumbWidth = self.thumbWidth * 0.5
        let newMargin = (totalWidth - touchLocation.x) + halfThumbWidth

        if newMargin < 0 {
            thumbRightConstraint?.constant = 0
        } else if (newMargin + thumbWidth) + thumbLeftPosition < totalWidth - 1 {
            thumbRightConstraint?.constant = -newMargin
        } else {
            thumbRightConstraint?.constant = -(totalWidth - thumbLeftPosition - thumbWidth) + 1
        }
        endTime = calculateEndTime()
        delegate?.didChangeValue(videoRangeSlider: self, endTime: endTime)
    }

}
