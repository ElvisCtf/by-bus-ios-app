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


// MARK: - UIImageView
extension UIImageView {
    static func system(id: String = "", name: String, color: UIColor, contenMode: UIView.ContentMode = .scaleAspectFill) -> UIImageView {
        let img = UIImage(systemName: name)?.withRenderingMode(.alwaysTemplate)
        let imgView = UIImageView(image: img)
        imgView.addAccessibilityID(id)
        imgView.contentMode = contenMode
        imgView.tintColor = color
        return imgView
    }
}

// MARK: - UIButton
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
