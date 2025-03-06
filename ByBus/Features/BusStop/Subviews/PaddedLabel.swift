//
//  PaddedLabel.swift
//  ByBus
//
//  Created by Elvis Cheng on 5/3/2025.
//

import UIKit
import SnapKit

final class PaddedLabel: UIView {
    private let padding: UIEdgeInsets
    private let borderColor: UIColor
    private let label: UILabel
    
    var text: String? = nil {
        didSet {
            label.text = text
        }
    }
    
    init(id: String = "", lines: Int = 0, alignment: NSTextAlignment = .left, weight: UIFont.Weight, size: CGFloat, color: UIColor, text: String? = "", padding: UIEdgeInsets, borderColor: UIColor = .clear) {
        self.padding = padding
        self.borderColor = borderColor
        self.label = UILabel.plain(id: id, lines: lines, alignment: alignment, weight: weight, size: size, color: color, text: text)
        
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = borderColor.cgColor
    }
    
    private func setLayout() {
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(padding.top)
            $0.left.equalToSuperview().inset(padding.left)
            $0.bottom.equalToSuperview().inset(padding.bottom)
            $0.right.equalToSuperview().inset(padding.right)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
