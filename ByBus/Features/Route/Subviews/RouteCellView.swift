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
    let companyLbl = UILabel.plain(id: UI.company.id, lines: 1, alignment: .center, weight: .regular, size: 13, color: .label)
    let routeNoLbl = UILabel.plain(id: UI.routeNo.id, lines: 1, alignment: .center, weight: .semibold, size: 17, color: .label)
    let originLbl  = UILabel.plain(id: UI.origin.id, lines: 0, weight: .regular, size: 17, color: .label)
    let destinLbl  = UILabel.plain(id: UI.destin.id, lines: 0, weight: .regular, size: 17, color: .label)
    let fromLbl    = UILabel.plain(id: UI.from.id, lines: 1, weight: .light, size: 13, color: .label)
    let toLbl      = UILabel.plain(id: UI.to.id, lines: 1, weight: .light, size: 13, color: .label)
    
    let leftLblVstack  = UIStackView.vertical(spacing: 8, padding: .zero)
    let rightLblVstack  = UIStackView.vertical(spacing: 8, padding: .zero)
    let lblHstack1 = UIStackView.horizontal(spacing: 6, padding: .zero, distribution: .fill)
    let lblHstack2 = UIStackView.horizontal(spacing: 6, padding: .zero, distribution: .fill)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    func setUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        companyLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        routeNoLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        toLbl.setContentHuggingPriority(.defaultLow + 2, for: .horizontal)
        fromLbl.setContentHuggingPriority(.defaultLow + 2, for: .horizontal)
        
        rootView.border(color: .separator)
    }
    
    func setLayout() {
        contentView.addSubview(rootView)
        rootView.addSubview(leftLblVstack)
        rootView.addSubview(rightLblVstack)
        
        leftLblVstack.addSubviews([companyLbl, routeNoLbl])
        lblHstack1.addSubviews([fromLbl, originLbl])
        lblHstack2.addSubviews([toLbl, destinLbl])
        rightLblVstack.addSubviews([lblHstack1, lblHstack2])
        
        rootView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
        
        leftLblVstack.snp.makeConstraints {
            $0.left.equalToSuperview().inset(12)
            $0.centerY.equalTo(rightLblVstack.snp.centerY)
            $0.width.equalToSuperview().multipliedBy(0.15)
        }
        
        rightLblVstack.snp.makeConstraints {
            $0.left.equalTo(leftLblVstack.snp.right).offset(18)
            $0.top.bottom.right.equalToSuperview().inset(12)
        }
        
        toLbl.snp.makeConstraints {
            $0.width.equalTo(fromLbl.snp.width)
        }
    }
    
    func setText(with route: Route) {
        companyLbl.text = route.company?.name
        routeNoLbl.text = route.routeNo
        destinLbl.text  = route.destination.value
        originLbl.text  = route.origin.value
        fromLbl.text    = String(localized: "from")
        toLbl.text      = String(localized: "to")
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
