//
//  UITrimVideoView.swift
//  TrimVideoView
//
//  Created by Eduardo Fornari on 13/08/19.
//  Copyright © 2019 Eduardo Fornari. All rights reserved.
//

import UIKit

@IBDesignable class UITrimVideoView: UIView {

    @IBInspectable var color: UIColor? = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)

    private var borderWidth: CGFloat = 2

    private var contentView = UIView()
    private var framesView = UIView()

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

}
