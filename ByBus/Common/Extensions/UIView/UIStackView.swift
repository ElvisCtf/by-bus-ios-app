//
//  UIStackView.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import UIKit

extension UIStackView {
    static func vertical(spacing: CGFloat, padding: UIEdgeInsets, distribution: UIStackView.Distribution = .fillEqually, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        return UIStackView(axis: .vertical, spacing: spacing, padding: padding, distribution: distribution, alignment: alignment)
    }
    
    static func horizontal(spacing: CGFloat, padding: UIEdgeInsets, distribution: UIStackView.Distribution = .fillEqually, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        return UIStackView(axis: .horizontal, spacing: spacing, padding: padding, distribution: distribution, alignment: alignment)
    }
    
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, padding: UIEdgeInsets, distribution: UIStackView.Distribution = .fillEqually, alignment: UIStackView.Alignment = .fill) {
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.layoutMargins = padding
        self.distribution = distribution
        self.alignment = alignment
        self.isLayoutMarginsRelativeArrangement = true
    }
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
