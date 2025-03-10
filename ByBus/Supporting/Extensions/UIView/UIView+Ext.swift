//
//  UIView+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/12/2024.
//

import UIKit

extension UIView {
    static func plain(cornerRadius: CGFloat = 0, isClipsToBounds: Bool = false, bgColor: UIColor = .clear) -> UIView {
        let v = UIView()
        if cornerRadius > 0 {
            v.layer.cornerRadius = cornerRadius
        }
        v.clipsToBounds = isClipsToBounds
        v.backgroundColor = bgColor
        return v
    }
    
    func addAccessibilityID(_ id: String) {
        if !id.isEmpty {
            self.accessibilityIdentifier = id
        }
    }
}
