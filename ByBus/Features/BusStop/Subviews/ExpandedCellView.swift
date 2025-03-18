//
//  ExpandedCellView.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ExpandedCellView: UITableViewCell {
    static let reuseID = "ExpandedCellView"
    private let arrivalTimeLbl = UILabel.plain(weight: .regular, size: 15, color: .secondaryLabel)
    private let bookmarkBtn = UIButton.selected(id: UI.bookmarkBtn.id, normalImg: "bookmark", selectedImg: "bookmark.fill")
    
    private var busStop: BusStop?
    var onSelect: ((Bool, BusStop) -> Void)?
    
    private let disposeBag = DisposeBag()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        setBinding()
    }
    
    private func setUI() {
        selectionStyle = .none
        contentView.backgroundColor = .secondarySystemGroupedBackground
        bookmarkBtn.isHidden = true
    }
    
    private func setLayout() {
        contentView.addSubview(arrivalTimeLbl)
        contentView.addSubview(bookmarkBtn)
        
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
    
    private func setBinding() {
        bookmarkBtn.rx.tap.asSignal().emit(onNext: { [weak self] in
            guard let self else { return }
            self.bookmarkBtn.isSelected.toggle()
            if let busStop {
                self.onSelect?(self.bookmarkBtn.isSelected, busStop)
            }
        }).disposed(by: disposeBag)
    }
    
    func setText(with busStop: BusStop) {
        self.busStop = busStop
        arrivalTimeLbl.text = busStop.arrivalTime
        bookmarkBtn.isSelected = busStop.isSaved
        
        if busStop.arrivalTime != "" && busStop.isExpanded {
            bookmarkBtn.isHidden = false
        } else {
            bookmarkBtn.isHidden = true
        }
    }
    
    func setText(_ text: String, isExpanded: Bool) {
        arrivalTimeLbl.text = text
        bookmarkBtn.isSelected = true
        
        if text != "" && isExpanded {
            bookmarkBtn.isHidden = false
        } else {
            bookmarkBtn.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Accessibiltiy Identifier
extension ExpandedCellView {
    enum UI: String {
        case arrivalTimeLbl = "arrivalTimeLabel"
        case bookmarkBtn    = "bookmarkButton"
        
        var id: String {
            return "\(reuseID)_\(rawValue)"
        }
    }
}
