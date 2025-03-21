//
//  BusStopCellView.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

import UIKit
import SnapKit
import RxSwift

final class BusStopCellView: UITableViewCell {
    static let reuseID = "BusStopCellView"
    
    var onSelect: ((BusStop) -> Void)?
    private var busStop: BusStop?
    
    private let rootView = UIView.plain(cornerRadius: 8, bgColor: .systemBackground)
    private let nameLbl = UILabel.plain(id: UI.busStopNameLbl.id, lines: 1, weight: .regular, size: 17, color: .label)
    private let separator = UIView.plain(bgColor: .separator)
    private let etaView = EtaView()
    private let disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        setBinding()
    }
    
    private func setUI() {
        selectionStyle = .none
        backgroundColor = .clear
        rootView.border(color: .separator)
        separator.isHidden = true
    }
    
    private func setLayout() {
        contentView.addSubview(rootView)
        rootView.addSubview(nameLbl)
        rootView.addSubview(separator)
        rootView.addSubview(etaView)
        
        rootView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
        
        nameLbl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(nameLbl.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        etaView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
    }
    
    private func setBinding() {
        etaView.bookmarkBtn.rx.tap.asSignal().emit(onNext: { [weak self] in
            guard let self else { return }
            self.etaView.bookmarkBtn.isSelected.toggle()
            if let busStop {
                self.onSelect?(busStop)
            }
        }).disposed(by: disposeBag)
    }
    
    func setText(with busStop: BusStop) {
        self.busStop = busStop
        nameLbl.text = "\(busStop.index). \(busStop.name.tc)"
        etaView.setText(busStop.arrivalTime, isExpanded: busStop.isExpanded, isSaved: busStop.isSaved)
        separator.isHidden = !busStop.isExpanded
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Accessibility Identifier
extension BusStopCellView {
    enum UI: String {
        case busStopNameLbl = "busStopNameLabel"
        
        var id: String {
            return "\(reuseID)_\(rawValue)"
        }
    }
}
