//
//  UIButton+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import UIKit

extension UIButton {
    static func filled(id: String = "", weight: UIFont.Weight, size: CGFloat, textColor: UIColor, text: String? = "", bgColor: UIColor, cornerRadius: CGFloat, padding: NSDirectionalEdgeInsets) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = text
        config.baseBackgroundColor = bgColor
        config.baseForegroundColor = textColor
        config.contentInsets = padding
        
        let btn = UIButton(configuration: config)
        btn.addAccessibilityID(id)
        btn.titleLabel?.font = .systemFont(ofSize: size, weight: weight)
        return btn
    }
    
    static func icon(id: String = "", imgName: String, bgColor: UIColor, imgColor: UIColor = .white) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: imgName)
        config.imagePlacement = .all
        config.baseBackgroundColor = bgColor
        config.baseForegroundColor = imgColor
        
        let btn = UIButton(configuration: config)
        btn.addAccessibilityID(id)
        return btn
    }
}
