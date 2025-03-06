//
//  BusStopViewController.swift
//  ByBus
//
//  Created by Elvis Cheng on 18/2/2025.
//

import UIKit

class BusStopViewController: UIViewController {
    private lazy var busStopView = BusStopView(with: route)
    private var route: Route
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    init(route: Route) {
        self.route = route
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        view = busStopView
        busStopView.backBtn.addTarget(self, action: #selector(onBack), for: .touchUpInside)
    }
    
    @objc private func onBack() {
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
