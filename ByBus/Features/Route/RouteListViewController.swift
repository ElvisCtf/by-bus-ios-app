//
//  RouteListViewController.swift
//  ByBus
//
//  Created by Elvis Cheng on 26/11/2024.
//

import UIKit

class RouteListViewController: UIViewController {
    private let viewModel = RouteListViewModel()
    private lazy var routeListView = RouteListView(with: viewModel)

    override func viewDidLoad() {
        super.viewDidLoad()
        view = routeListView
    }
}

