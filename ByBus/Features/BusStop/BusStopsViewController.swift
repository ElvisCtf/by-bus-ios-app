//
//  BusStopsViewController.swift
//  ByBus
//
//  Created by Elvis Cheng on 18/2/2025.
//

import UIKit

class BusStopsViewController: UIViewController {
    private lazy var busStopView = BusStopsView(with: viewModel)
    private lazy var viewModel = BusStopsViewModel(with: route)
    
    private var route: Route
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    init(route: Route) {
        self.route = route
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = route.routeNo
        setUI()
    }
    
    private func setUI() {
        view = busStopView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
