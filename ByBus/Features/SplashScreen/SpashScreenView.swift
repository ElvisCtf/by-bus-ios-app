//
//  SpashScreenView.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import UIKit
import SnapKit

final class SplashScreenView: UIView {
    private let logo = UIImageView.named(name: "logo")
    private let spinner = UIActivityIndicatorView(style: .large)
    
    init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        backgroundColor = .systemBackground
        spinner.color = .systemOrange
    }
    
    private func setLayout() {
        addSubview(logo)
        addSubview(spinner)
        
        logo.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(150)
        }
        
        spinner.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logo.snp.bottom).offset(36)
        }
        
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
