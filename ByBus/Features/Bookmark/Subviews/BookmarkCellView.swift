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
    private let stopLbl = UILabel.plain(id: UI.stop.id, lines: 1, weight: .regular, size: 17, color: .label)
    private let lblHstack3 = UIStackView.horizontal(spacing: 4, padding: .zero, distribution: .fill)
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
        
        fromLbl.text       = "由"
        toLbl.text         = "往"
        stopPrefixLbl.text = "站"
        
        separator.isHidden = true
    }
 
    override func setLayout() {
        contentView.addSubview(rootView)
        rootView.addSubview(companyLbl)
        rootView.addSubview(routeNoLbl)
        rootView.addSubview(lblVstack)
        rootView.addSubview(separator)
        rootView.addSubview(etaView)
        
        lblHstack1.addSubviews([fromLbl, originLbl])
        lblHstack2.addSubviews([toLbl, destinLbl])
        lblHstack3.addSubviews([stopPrefixLbl, stopLbl])
        lblVstack.addSubviews([lblHstack1, lblHstack2, lblHstack3])
        
        rootView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
        
        companyLbl.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalTo(lblVstack.snp.centerY)
        }
        
        routeNoLbl.snp.makeConstraints {
            $0.left.equalTo(companyLbl.snp.right).offset(16)
            $0.centerY.equalTo(lblVstack.snp.centerY)
            $0.width.equalTo(48)
        }
        
        lblVstack.snp.makeConstraints {
            $0.left.equalTo(routeNoLbl.snp.right).offset(24)
            $0.right.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(12)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(lblVstack.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        etaView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(4)
            $0.left.bottom.right.equalToSuperview()
        }
    }
    
    func setText(with bookmark: BusStopBookmark, eta: String, isExpanded: Bool) {
        companyLbl.text    = Company.ctb.zhName
        routeNoLbl.text    = bookmark.routeNo
        destinLbl.text     = bookmark.origin.tc
        originLbl.text     = bookmark.destination.tc
        stopLbl.text       = bookmark.name.tc
        
        etaView.setText(eta, isExpanded: isExpanded)
        separator.isHidden = !isExpanded
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BookmarkCellView {
    class EtaView: UIView {
        enum UI: String {
            case arrivalTimeLbl = "arrivalTimeLabel"
            case bookmarkBtn    = "bookmarkButton"
            
            var id: String {
                return "EtaView_\(rawValue)"
            }
        }
        
        private var busStop: BusStop?
        private let arrivalTimeLbl = UILabel.plain(weight: .regular, size: 15, color: .secondaryLabel)
        private let bookmarkBtn = UIButton.selected(id: UI.bookmarkBtn.id, normalImg: "bookmark", selectedImg: "bookmark.fill")
        
        init() {
            super.init(frame: .zero)
            setUI()
            setLayout()
        }
        
        private func setUI() {
            bookmarkBtn.isHidden = true
        }
        
        private func setLayout() {
            addSubview(arrivalTimeLbl)
            addSubview(bookmarkBtn)
            
            arrivalTimeLbl.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.left.equalToSuperview().inset(16)
            }
            
            bookmarkBtn.snp.makeConstraints {
                $0.centerY.equalTo(arrivalTimeLbl.snp.centerY)
                $0.left.equalTo(arrivalTimeLbl.snp.right).offset(8)
                $0.right.equalToSuperview().inset(16)
                $0.size.equalTo(24)
            }
        }
        
        func setText(with busStop: BusStop) {
            self.busStop = busStop
            bookmarkBtn.isSelected = busStop.isSaved
            if busStop.arrivalTime != "" && busStop.isExpanded {
                arrivalTimeLbl.text = busStop.arrivalTime
                bookmarkBtn.isHidden = false
            } else {
                arrivalTimeLbl.text = ""
                bookmarkBtn.isHidden = true
            }
        }
        
        func setText(_ text: String, isExpanded: Bool) {
            bookmarkBtn.isSelected = true
            
            if text != "" && isExpanded {
                self.arrivalTimeLbl.text = text
                self.bookmarkBtn.isHidden = false
            } else {
                self.arrivalTimeLbl.text = ""
                self.bookmarkBtn.isHidden = true
            }
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
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
