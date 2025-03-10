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
    
    private let companyLbl = UILabel.plain(id: UI.company.id, lines: 1, weight: .regular, size: 13, color: .label)
    private let routeNoLbl = UILabel.plain(id: UI.routeNo.id, lines: 1, alignment: .center, weight: .semibold, size: 17, color: .label)
    private let originLbl  = UILabel.plain(id: UI.origin.id, lines: 1, weight: .regular, size: 17, color: .label)
    private let destinLbl  = UILabel.plain(id: UI.destin.id, lines: 1, weight: .semibold, size: 17, color: .label)
    private let fromLbl    = UILabel.plain(id: UI.from.id, lines: 1, weight: .regular, size: 13, color: .label)
    private let toLbl      = UILabel.plain(id: UI.to.id, lines: 1, weight: .regular, size: 13, color: .label)
    
    private let lblVstack  = UIStackView.vertical(spacing: 8, padding: .zero)
    private let lblHstack1 = UIStackView.horizontal(spacing: 4, padding: .zero, distribution: .fill)
    private let lblHstack2 = UIStackView.horizontal(spacing: 4, padding: .zero, distribution: .fill)
    private let separator  = UIView.plain(bgColor: .separator)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        selectionStyle = .none
        
        companyLbl.setContentHuggingPriority(.defaultLow + 2, for: .horizontal)
        routeNoLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        toLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        fromLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        
        lblHstack1.alignment = .bottom
        lblHstack2.alignment = .bottom
    }
    
    private func setLayout() {
        contentView.addSubview(companyLbl)
        contentView.addSubview(routeNoLbl)
        contentView.addSubview(lblVstack)
        contentView.addSubview(separator)
        
        lblHstack1.addSubviews([fromLbl, originLbl])
        lblHstack2.addSubviews([toLbl, destinLbl])
        lblVstack.addSubviews([lblHstack1, lblHstack2])
        
        companyLbl.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        routeNoLbl.snp.makeConstraints {
            $0.left.equalTo(companyLbl.snp.right).offset(16)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(48)
        }
        
        lblVstack.snp.makeConstraints {
            $0.left.equalTo(routeNoLbl.snp.right).offset(24)
            $0.right.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        separator.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func setText(with route: Route) {
        companyLbl.text = route.company?.zhName
        routeNoLbl.text = route.routeNo
        destinLbl.text  = route.destTc
        originLbl.text  = route.origTc
        fromLbl.text    = "由"
        toLbl.text      = "往"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Accessibility Identifier
extension RouteCellView {
    enum UI: String {
        case company = "companyLabel"
        case routeNo = "routeNumberLabel"
        case destin  = "destinationLabel"
        case origin  = "originLabel"
        case from    = "fromLabel"
        case to      = "toLabel"
        
        var id : String {
            return "\(reuseID)_\(rawValue)"
        }
    }
}
