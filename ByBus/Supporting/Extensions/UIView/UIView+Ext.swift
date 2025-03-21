//
//  UIView+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/12/2024.
//

import UIKit

extension UIView {
    static func plain(cornerRadius: CGFloat = 0, bgColor: UIColor = .clear) -> UIView {
        let v = UIView()
        if cornerRadius > 0 {
            v.layer.cornerRadius = cornerRadius
            v.clipsToBounds = true
        }
        v.backgroundColor = bgColor
        return v
    }
    
    func addAccessibilityID(_ id: String) {
        if !id.isEmpty {
            self.accessibilityIdentifier = id
        }
    }
    
    func border(width: CGFloat = 1, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
