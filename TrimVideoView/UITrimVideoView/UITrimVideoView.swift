//
//  UITrimVideoView.swift
//  TrimVideoView
//
//  Created by Eduardo Fornari on 13/08/19.
//  Copyright © 2019 Eduardo Fornari. All rights reserved.
//

import UIKit

class UITrimVideoView: UIView {

    private var borderWidth: CGFloat = 2

    private var contentView = UIView()
    private var framesView = UIView()

    private var thumbWidth: CGFloat = 10

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

}
