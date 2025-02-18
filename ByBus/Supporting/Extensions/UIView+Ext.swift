//
//  UIView+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/12/2024.
//

import UIKit
import SnapKit


// MARK: - UILabel
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


// MARK: - UIStackView
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


// MARK: - UITableView
extension UITableView {
    static func plain(id: String = "", backgroundColor: UIColor = .clear, separateStyle: UITableViewCell.SeparatorStyle = .none) -> UITableView {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.accessibilityIdentifier = id
        return tv
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}


// MARK: - UIView
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
