//
//  UIImageView+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import UIKit

extension UIImageView {
    static func system(id: String = "", name: String, color: UIColor?, contenMode: UIView.ContentMode = .scaleAspectFill) -> UIImageView {
        let img = UIImage(systemName: name)?.withRenderingMode(.alwaysTemplate)
        let imgView = UIImageView(image: img)
        imgView.addAccessibilityID(id)
        imgView.contentMode = contenMode
        if let color {
            imgView.tintColor = color
        }
        return imgView
    }
    
    static func named(id: String = "", name: String, contenMode: UIView.ContentMode = .scaleAspectFill) -> UIImageView {
        let img = UIImage(named: name)
        let imgView = UIImageView(image: img)
        imgView.addAccessibilityID(id)
        imgView.contentMode = contenMode
        imgView.tintColor = .white
        return imgView
    }
}
