//
//  RouteCellView.swift
//  ByBus
//
//  Created by Elvis Cheng on 9/12/2024.
//

import UIKit
import SnapKit

final class RouteCellView: UITableViewCell {
    static let reuseID = "RouteCellView"
    
    private let companyLbl = UILabel.plain(lines: 1, weight: .regular, size: 14, color: .label)
    private let routeLbl = UILabel.plain(lines: 1, weight: .semibold, size: 18, color: .label)
    private let destinLbl = UILabel.plain(lines: 1, weight: .semibold, size: 18, color: .label)
    private let originLbl = UILabel.plain(lines: 1, weight: .regular, size: 18, color: .secondaryLabel)
    private let fromLbl = UILabel.plain(lines: 1, weight: .regular, size: 14, color: .secondaryLabel)
    private let toLbl = UILabel.plain(lines: 1, weight: .semibold, size: 14, color: .label)
    
    private let lblVstack = UIStackView.vertical(spacing: 8, padding: .zero)
    private let lblHstack1 = UIStackView.horizontal(spacing: 4, padding: .zero, distribution: .fill)
    private let lblHstack2 = UIStackView.horizontal(spacing: 4, padding: .zero, distribution: .fill)
    
    private let separator = UIView.plain(bgColor: .separator)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        selectionStyle = .none
        
        companyLbl.setContentHuggingPriority(.defaultLow + 2, for: .horizontal)
        routeLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        fromLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        toLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        
        lblHstack1.alignment = .bottom
        lblHstack2.alignment = .bottom
    }
    
    private func setLayout() {
        contentView.addSubview(companyLbl)
        contentView.addSubview(routeLbl)
        contentView.addSubview(lblVstack)
        contentView.addSubview(separator)
        
        lblHstack1.addArrangedSubview(toLbl)
        lblHstack1.addArrangedSubview(destinLbl)
        
        lblHstack2.addArrangedSubview(fromLbl)
        lblHstack2.addArrangedSubview(originLbl)
        
        lblVstack.addArrangedSubview(lblHstack1)
        lblVstack.addArrangedSubview(lblHstack2)
        
        companyLbl.snp.makeConstraints {
            $0.left.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        routeLbl.snp.makeConstraints {
            $0.left.equalTo(companyLbl.snp.right).offset(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        lblVstack.snp.makeConstraints {
            $0.left.equalTo(routeLbl.snp.right).offset(32)
            $0.right.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        separator.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.bottom.equalToSuperview()
        }
        
        setText("")
    }
    
    func setText(_ text: String) {
        companyLbl.text = "城巴"
        routeLbl.text = "10"
        destinLbl.text = "北角碼頭"
        originLbl.text = "堅尼地城"
        fromLbl.text = "從"
        toLbl.text = "往"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

