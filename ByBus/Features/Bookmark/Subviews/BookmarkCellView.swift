//
//  BookmarkCellView.swift
//  ByBus
//
//  Created by Elvis Cheng on 18/3/2025.
//

import UIKit
import SnapKit

final class BookmarkCellView: RouteCellView {
    override class var reuseID: String {
        return "BookmarkCellView"
    }
    
    private let stopPrefixLbl = UILabel.plain(id: UI.stopPrefix.id, lines: 1, weight: .light, size: 13, color: .label)
    private let stopLbl = UILabel.plain(id: UI.stop.id, lines: 0, weight: .regular, size: 17, color: .label)
    private let lblHstack3 = UIStackView.horizontal(spacing: 6, padding: .zero, distribution: .fill)
    private let separator = UIView.plain(bgColor: .separator)
    private let etaView = EtaView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    override func setUI() {
        super.setUI()
        stopPrefixLbl.setContentHuggingPriority(.defaultLow + 2, for: .horizontal)
        stopLbl.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        
        fromLbl.text       = String(localized: "from")
        toLbl.text         = String(localized: "to")
        stopPrefixLbl.text = String(localized: "station")
        
        separator.isHidden = true
    }
 
    override func setLayout() {
        contentView.addSubview(rootView)
        rootView.addSubview(leftLblVstack)
        rootView.addSubview(rightLblVstack)
        rootView.addSubview(separator)
        rootView.addSubview(etaView)
        
        leftLblVstack.addSubviews([companyLbl, routeNoLbl])
        lblHstack1.addSubviews([fromLbl, originLbl])
        lblHstack2.addSubviews([toLbl, destinLbl])
        lblHstack3.addSubviews([stopPrefixLbl, stopLbl])
        rightLblVstack.addSubviews([lblHstack1, lblHstack2, lblHstack3])
        
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
            $0.top.right.equalToSuperview().inset(12)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(rightLblVstack.snp.bottom).offset(12)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        etaView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
        
        fromLbl.snp.makeConstraints {
            $0.width.equalTo(stopPrefixLbl.snp.width)
        }
        
        toLbl.snp.makeConstraints {
            $0.width.equalTo(stopPrefixLbl.snp.width)
        }
    }
    
    func setText(with bookmark: BusStopBookmark, eta: String, isExpanded: Bool) {
        companyLbl.text    = Company.ctb.name
        routeNoLbl.text    = bookmark.routeNo
        destinLbl.text     = bookmark.origin.value
        originLbl.text     = bookmark.destination.value
        stopLbl.text       = bookmark.name.value
        etaView.setText(eta, isExpanded: isExpanded)
        separator.isHidden = !isExpanded
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Accessibility Identifier
extension BookmarkCellView {
    enum UI: String {
        case stopPrefix = "stopPrefixLabel"
        case stop = "stopLabel"
        
        var id : String {
            return "\(reuseID)_\(rawValue)"
        }
    }
}
