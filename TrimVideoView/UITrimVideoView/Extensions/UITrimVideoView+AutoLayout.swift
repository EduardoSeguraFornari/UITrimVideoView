//
//  UITrimVideoView+AutoLayout.swift
//  TrimVideoView
//
//  Created by Eduardo Fornari on 13/08/19.
//  Copyright © 2019 Eduardo Fornari. All rights reserved.
//

import UIKit

// MARK: - Auto Layout
extension UITrimVideoView {

    internal func registerAutoLayoutNotifications() {
        let action = #selector(didRotate)
        NotificationCenter.default.addObserver(self, selector: action,
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }

    @objc private func didRotate() {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            if let isPortrait = isPortrait {
                if isPortrait {
                    setup()
                }
            } else {
                setup()
            }
            isPortrait = false
        case .portrait, .portraitUpsideDown:
            if let isPortrait = isPortrait {
                if !isPortrait {
                    setup()
                }
            } else {
                setup()
            }
            isPortrait = true
        default:
            return
        }
    }

    internal func setupIsPortraitFlag() {
        let mainViewSize = UIScreen.main.bounds
        isPortrait = mainViewSize.width < mainViewSize.height ? true : false
    }

}
