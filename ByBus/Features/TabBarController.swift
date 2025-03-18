//
//  TabBarController.swift
//  ByBus
//
//  Created by Elvis Cheng on 26/11/2024.
//

import UIKit

final class TabBarController: UITabBarController {
    private var routes: [Route]
    
    private lazy var routeTab = UINavigationController(
        title: "Route",
        defaultImage: "bus",
        selectedImage: "bus.fill",
        viewController: RoutesViewController(routes: routes)
    )
    
    private lazy var bookmarkTab = UINavigationController(
        title: "Bookmark",
        defaultImage: "bookmark",
        selectedImage: "bookmark.fill",
        viewController: BookmarksViewController()
    )
    
    private lazy var settingTab = UINavigationController(
        title: "Setting",
        defaultImage: "gearshape",
        selectedImage: "gearshape.fill",
        viewController: SettingViewController()
    )
    
    override func viewDidLoad() {
        self.viewControllers = [routeTab, bookmarkTab, settingTab]
    }
    
    init(routes: [Route]) {
        self.routes = routes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
