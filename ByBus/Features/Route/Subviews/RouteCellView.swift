//
//  RouteCellView.swift
//  ByBus
//
//  Created by Elvis Cheng on 9/12/2024.
//

import UIKit
import SnapKit

class RouteCellView: UITableViewCell {
    class var reuseID: String {
        return "RouteCellView"
    }
    
    let rootView   = UIView.plain(cornerRadius: 8, bgColor: .systemBackground)
    let companyLbl = UILabel.plain(id: UI.company.id, lines: 1, weight: .regular, size: 13, color: .label)
    let routeNoLbl = UILabel.plain(id: UI.routeNo.id, lines: 1, alignment: .center, weight: .semibold, size: 17, color: .label)
    let originLbl  = UILabel.plain(id: UI.origin.id, lines: 1, weight: .regular, size: 17, color: .label)
    let destinLbl  = UILabel.plain(id: UI.destin.id, lines: 1, weight: .regular, size: 17, color: .label)
    let fromLbl    = UILabel.plain(id: UI.from.id, lines: 1, weight: .light, size: 13, color: .label)
    let toLbl      = UILabel.plain(id: UI.to.id, lines: 1, weight: .light, size: 13, color: .label)
    
    let lblVstack  = UIStackView.vertical(spacing: 8, padding: .zero)
    let lblHstack1 = UIStackView.horizontal(spacing: 4, padding: .zero, distribution: .fill)
    let lblHstack2 = UIStackView.horizontal(spacing: 4, padding: .zero, distribution: .fill)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    func setUI() {
        selectionStyle = .none
        
        companyLbl.setContentHuggingPriority(.defaultLow + 2, for: .horizontal)
        routeNoLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        toLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        fromLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        
        rootView.border(color: .separator)
        
        backgroundColor = .clear
    }
    
    func setLayout() {
        contentView.addSubview(rootView)
        rootView.addSubview(companyLbl)
        rootView.addSubview(routeNoLbl)
        rootView.addSubview(lblVstack)
        
        lblHstack1.addSubviews([fromLbl, originLbl])
        lblHstack2.addSubviews([toLbl, destinLbl])
        lblVstack.addSubviews([lblHstack1, lblHstack2])
        
        rootView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
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
