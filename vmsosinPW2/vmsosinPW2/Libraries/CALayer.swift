//
//  CALayer.swift
//  vmsosinPW2
//
//  Created by Sosin Vladislav on 24.09.2022.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = .systemGray,
        opacity: Float = 0.5,
        radius: CGFloat = 10
    ) {
        self.shadowColor = color.cgColor
        self.shadowOpacity = opacity
        self.shadowOffset = .zero
        self.shadowRadius = radius
    }
}
