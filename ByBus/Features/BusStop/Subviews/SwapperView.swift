//
//  SwapperView.swift
//  ByBus
//
//  Created by Elvis Cheng on 5/3/2025.
//

import UIKit
import SnapKit

final class SwapperView: UIView {
    private let originIcon = UIImageView.system(name: "circle", color: .label)
    private let dotIcon = UIImageView.system(name: "arrow.down", color: .label)
    private let destinIcon = UIImageView.system(name: "mappin.and.ellipse", color: .systemRed)
    private let iconVstack = UIStackView.vertical(spacing: 10, padding: .zero)
    
    private let originLbl = PaddedLabel(weight: .regular, size: 17, color: .label, padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), borderColor: .systemGray2)
    private let destinLbl = PaddedLabel(weight: .semibold, size: 17, color: .label, padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), borderColor: .systemGray2)
   
    let swapBtn = UIButton.icon(imgName: "arrow.up.arrow.down", bgColor: .clear, imgColor: .systemBlue)
    
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
            $0.top.equalToSuperview()
            $0.left.equalTo(iconVstack.snp.right).offset(8)
            $0.centerY.equalTo(originIcon.snp.centerY)
        }
        
        destinLbl.snp.makeConstraints {
            $0.bottom.equalToSuperview()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
