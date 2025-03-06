//
//  BusStopView.swift
//  ByBus
//
//  Created by Elvis Cheng on 18/2/2025.
//

import UIKit
import SnapKit

final class BusStopView: UIView {
    static let name = "BusStopView"
    private let route: Route
    private let originDestinView = SwapperView()
    private let separator = UIView.plain(bgColor: .separator)
    let backBtn = UIButton.icon(imgName: "chevron.left", bgColor: .clear, imgColor: .systemBlue)
    
    init(with route: Route) {
        self.route = route
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        backgroundColor = .systemBackground
        originDestinView.setText(origin: route.origTc, destin: route.destTc)
    }
    
    private func setLayout() {
        addSubview(backBtn)
        addSubview(originDestinView)
        addSubview(separator)
        
        backBtn.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalTo(originDestinView.snp.centerY)
            $0.size.equalTo(24)
        }
        
        originDestinView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(backBtn.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(originDestinView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
