//
//  ExpandedCellView.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

import UIKit
import SnapKit

final class ExpandedCellView: UITableViewCell {
    static let reuseID = "ExpandedCellView"
    private let arrivalTimeLbl = UILabel.plain(weight: .regular, size: 15, color: .secondaryLabel)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        selectionStyle = .none
        contentView.backgroundColor = .secondarySystemGroupedBackground
    }
    
    private func setLayout() {
        contentView.addSubview(arrivalTimeLbl)
        
        arrivalTimeLbl.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    func setText(with busStop: BusStop) {
        arrivalTimeLbl.text = busStop.arrivalTime
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Accessibiltiy Identifier
extension ExpandedCellView {
    enum UI: String {
        case arrivalTimeLbl = "arrivalTimeLabel"
        
        var id: String {
            return "\(reuseID)_\(rawValue)"
        }
    }
}
