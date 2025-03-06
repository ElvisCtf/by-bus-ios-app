//
//  RouteListViewController.swift
//  ByBus
//
//  Created by Elvis Cheng on 26/11/2024.
//

import UIKit

class RouteListViewController: UIViewController {
    private let viewModel = RouteListViewModel()
    private lazy var routeListView = RouteListView(parentVC: self, with: viewModel)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.getRouteList()
    }
    
    func setUI() {
        view = routeListView
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

