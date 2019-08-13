//
//  UITrimVideoView.swift
//  TrimVideoView
//
//  Created by Eduardo Fornari on 13/08/19.
//  Copyright © 2019 Eduardo Fornari. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable class UITrimVideoView: UIView {

    private var asset: AVAsset?

    private var startTime: Double = 0
    private var endTime: Double = 0

    @IBInspectable private var blurEdges: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0)
    @IBInspectable private var blurMiddle: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0)

    @IBInspectable var color: UIColor? = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)

    private var borderWidth: CGFloat = 2

    private var contentView = UIView()
    internal var framesView = UIView()

    private var thumbWidth: CGFloat = 10

    private var thumbLeft = UIView()
    private var thumbLeftConstraint: NSLayoutConstraint?

    private var thumbRight = UIView()
    private var thumbRightConstraint: NSLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        setup()
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Setup
    internal func setup() {
        setContentView()
        if let asset = asset {
            contentView.layoutIfNeeded()
            framesView.layoutIfNeeded()
            setFrames(for: asset)
        }
    }

    // MARK: - Content View
    private func setContentView() {
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 40)
            ])

        setFramesView()
        setThumbLeft()
        setThumbRight()
        setBorderTop()
        setBorderBottom()
        setBlurLeft()
        setBlurRight()
        setBlurMiddle()
    }

    // MARK: - Frames View
    private func setFramesView() {
        framesView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        contentView.addSubview(framesView)
        framesView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            framesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -thumbWidth),
            framesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: thumbWidth),
            framesView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: borderWidth),
            framesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -borderWidth)
            ])

        framesView.layoutIfNeeded()
    }

    // MARK: Thumb
    private func setThumbLeft() {
        thumbLeft.backgroundColor = color

        contentView.addSubview(thumbLeft)
        thumbLeft.translatesAutoresizingMaskIntoConstraints = false

        let thumbLeftConstraint = thumbLeft.leadingAnchor.constraint(equalTo: leadingAnchor)
        self.thumbLeftConstraint = thumbLeftConstraint
        NSLayoutConstraint.activate([
            thumbLeft.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbLeft.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            thumbLeft.widthAnchor.constraint(equalToConstant: thumbWidth),
            thumbLeftConstraint
            ])
    }

    private func setThumbRight() {
        thumbRight.backgroundColor = color

        contentView.addSubview(thumbRight)
        thumbRight.translatesAutoresizingMaskIntoConstraints = false

        let thumbRightConstraint = thumbRight.rightAnchor.constraint(equalTo: rightAnchor)
        self.thumbRightConstraint = thumbRightConstraint
        NSLayoutConstraint.activate([
            thumbRight.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbRight.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            thumbRight.widthAnchor.constraint(equalToConstant: thumbWidth),
            thumbRightConstraint
            ])
    }

    // MARK: - Borders
    private func setBorderTop() {
        let border = UIView()
        border.backgroundColor = color

        contentView.addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            border.heightAnchor.constraint(equalToConstant: borderWidth),
            border.topAnchor.constraint(equalTo: contentView.topAnchor),
            border.rightAnchor.constraint(equalTo: thumbRight.leftAnchor),
            border.leftAnchor.constraint(equalTo: thumbLeft.rightAnchor)
            ])
    }

    private func setBorderBottom() {
        let border = UIView()
        border.backgroundColor = color

        contentView.addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            border.heightAnchor.constraint(equalToConstant: borderWidth),
            border.rightAnchor.constraint(equalTo: thumbRight.leftAnchor),
            border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            border.leftAnchor.constraint(equalTo: thumbLeft.rightAnchor)
            ])
    }

    // MARK: - Blurs
    private func setBlurLeft() {
        let blur = UIView()
        blur.backgroundColor = blurEdges

        contentView.addSubview(blur)
        blur.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: framesView.topAnchor),
            blur.rightAnchor.constraint(equalTo: thumbLeft.rightAnchor),
            blur.bottomAnchor.constraint(equalTo: framesView.bottomAnchor),
            blur.leftAnchor.constraint(equalTo: framesView.leftAnchor)
            ])

        contentView.bringSubviewToFront(thumbLeft)
    }

    private func setBlurRight() {
        let blur = UIView()
        blur.backgroundColor = blurEdges

        contentView.addSubview(blur)
        blur.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: framesView.topAnchor),
            blur.rightAnchor.constraint(equalTo: framesView.rightAnchor),
            blur.bottomAnchor.constraint(equalTo: framesView.bottomAnchor),
            blur.leftAnchor.constraint(equalTo: thumbRight.leftAnchor)
            ])

        contentView.bringSubviewToFront(thumbRight)
    }

    private func setBlurMiddle() {
        let blur = UIView()
        blur.backgroundColor = blurMiddle

        contentView.addSubview(blur)
        blur.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: framesView.topAnchor),
            blur.rightAnchor.constraint(equalTo: thumbRight.leftAnchor),
            blur.bottomAnchor.constraint(equalTo: framesView.bottomAnchor),
            blur.leftAnchor.constraint(equalTo: thumbLeft.rightAnchor)
            ])
    }

    public func set(asset: AVAsset?) {
        self.asset = asset
        startTime = 0
        endTime = asset?.duration.seconds ?? 0
        setup()
    }

}
