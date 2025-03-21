//
//  EtaView.swift
//  ByBus
//
//  Created by Elvis Cheng on 21/3/2025.
//

import UIKit
import SnapKit

final class EtaView: UIView {
    private var busStop: BusStop?
    private let arrivalTimeLbl = UILabel.plain(weight: .regular, size: 15, color: .secondaryLabel)
    let bookmarkBtn = UIButton.selected(id: UI.bookmarkBtn.id, normalImg: "bookmark", selectedImg: "bookmark.fill")
    
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
            $0.top.bottom.equalToSuperview().inset(0)
            $0.left.equalToSuperview().inset(16)
        }
        
        bookmarkBtn.snp.makeConstraints {
            $0.centerY.equalTo(arrivalTimeLbl.snp.centerY)
            $0.left.equalTo(arrivalTimeLbl.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
    }
    
    func setText(_ text: String, isExpanded: Bool, isSaved: Bool = true) {
        bookmarkBtn.isSelected = isSaved
        
        if text != "" && isExpanded {
            self.arrivalTimeLbl.text = text
            self.bookmarkBtn.isHidden = false
            updateEtaViewUI(padding: 12)
        } else {
            self.arrivalTimeLbl.text = ""
            self.bookmarkBtn.isHidden = true
            updateEtaViewUI(padding: 0)
        }
    }
    
    private func updateEtaViewUI(padding: CGFloat) {
        arrivalTimeLbl.snp.updateConstraints {
            $0.top.bottom.equalToSuperview().inset(padding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension EtaView {
    enum UI: String {
        case arrivalTimeLbl = "arrivalTimeLabel"
        case bookmarkBtn    = "bookmarkButton"
        
        var id: String {
            return "EtaView_\(rawValue)"
        }
    }
}

