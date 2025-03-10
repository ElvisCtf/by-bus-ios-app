//
//  RoutesViewController.swift
//  ByBus
//
//  Created by Elvis Cheng on 26/11/2024.
//

import UIKit

class RoutesViewController: UIViewController {
    private let viewModel: RoutesViewModel
    private lazy var routesView = RoutesView(parentVC: self, with: viewModel)
    
    init(routes: [Route]) {
        viewModel = RoutesViewModel(routes: routes)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        title = "路線"
        view = routesView
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
