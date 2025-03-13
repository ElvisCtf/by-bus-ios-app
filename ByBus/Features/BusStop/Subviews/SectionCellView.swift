//
//  SectionCellView.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

import UIKit
import SnapKit

final class SectionCellView: UITableViewCell {
    static let reuseID = "SectionCellView"
    private let stopLbl = UILabel.plain(id: "\(reuseID)_stopLabel", lines: 1, weight: .regular, size: 17, color: .label)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        selectionStyle = .none
        contentView.backgroundColor = .systemGroupedBackground
    }
    
    private func setLayout() {
        contentView.addSubview(stopLbl)
        
        stopLbl.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    func setText(with busStop: BusStop) {
        stopLbl.text = "\(busStop.index). \(busStop.name.0)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
