//
//  SwapperView.swift
//  ByBus
//
//  Created by Elvis Cheng on 5/3/2025.
//

import UIKit
import SnapKit

final class SwapperView: UIView {
    static let name = "SwapperView"
    
    private let originIcon = UIImageView.system(name: "circle", color: .label)
    private let dotIcon = UIImageView.system(name: "arrow.down", color: .label)
    private let destinIcon = UIImageView.system(name: "mappin.and.ellipse", color: .systemRed)
    private let iconVstack = UIStackView.vertical(spacing: 10, padding: .zero)
    
    private let originLbl = PaddedLabel(id: UI.originLbl.id, weight: .regular, size: 17, color: .label, padding: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12), borderColor: .systemGray2)
    private let destinLbl = PaddedLabel(id: UI.destinLbl.id, weight: .semibold, size: 17, color: .label, padding: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12), borderColor: .systemGray2)
   
    let swapBtn = UIButton.icon(id: UI.swapBtn.id, imgName: "arrow.up.arrow.down", bgColor: .clear, imgColor: .systemBlue)
    
    init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    private func setUI() {

    }
    
    private func setLayout() {
        iconVstack.addSubviews([originIcon, dotIcon, destinIcon])
        addSubview(iconVstack)
        addSubview(originLbl)
        addSubview(destinLbl)
        addSubview(swapBtn)
        
        originIcon.snp.makeConstraints {
            $0.size.equalTo(16)
        }
        
        dotIcon.snp.makeConstraints {
            $0.size.equalTo(16)
        }
        
        destinIcon.snp.makeConstraints {
            $0.size.equalTo(16)
        }
        
        iconVstack.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
        }
        
        originLbl.snp.makeConstraints {
            $0.left.equalTo(iconVstack.snp.right).offset(8)
            $0.centerY.equalTo(originIcon.snp.centerY)
        }
        
        destinLbl.snp.makeConstraints {
            $0.left.equalTo(iconVstack.snp.right).offset(8)
            $0.centerY.equalTo(destinIcon.snp.centerY)
            $0.width.equalTo(originLbl.snp.width)
        }
        
        swapBtn.snp.makeConstraints {
            $0.left.equalTo(originLbl.snp.right).offset(16)
            $0.right.equalToSuperview()
            $0.centerY.equalTo(dotIcon.snp.centerY)
            $0.size.equalTo(24)
        }
    }
    
    func setText(origin: String?, destin: String?) {
        originLbl.text = origin
        destinLbl.text = destin
    }
    
    func swap() {
        let temp = originLbl.text
        originLbl.text = destinLbl.text
        destinLbl.text = temp
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Accessibility Identifier
extension SwapperView {
    enum UI: String {
        case originLbl = "originLabel"
        case destinLbl = "destinationLabel"
        case swapBtn   = "swapButton"
        
        var id: String {
            return "\(name)_\(rawValue)"
        }
    }
}
