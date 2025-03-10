//
//  UILabel+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import UIKit
import SnapKit


extension UILabel {
    static func plain(id: String = "", lines: Int = 0, alignment: NSTextAlignment = .left, weight: UIFont.Weight, size: CGFloat, color: UIColor, text: String? = "") -> UILabel {
        let lbl = UILabel()
        lbl.addAccessibilityID(id)
        lbl.numberOfLines = lines
        lbl.textAlignment = alignment
        lbl.font = .systemFont(ofSize: size, weight: weight)
        lbl.textColor = color
        lbl.text = text
        return lbl
    }
    
    static func withIcon(imgName: String, imgSize: CGFloat, spacing: CGFloat, lbl: UILabel) -> UIView {
        let view = UIView(frame: .zero)
        let img = UIImageView(image: UIImage(named: imgName))
        view.addSubview(img)
        view.addSubview(lbl)
        
        img.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.size.equalTo(imgSize)
        }
        
        lbl.snp.makeConstraints {
            $0.centerY.equalTo(img.snp.centerY)
            $0.left.equalTo(img.snp.right).offset(spacing)
            $0.right.equalToSuperview()
        }
        
        return view
    }
}
