//
//  TabBarController.swift
//  ByBus
//
//  Created by Elvis Cheng on 26/11/2024.
//

import UIKit

final class TabBarController: UITabBarController {
    private var routeTab    = UINavigationController(title: "Route", defaultImage: "bus", selectedImage: "bus.fill", viewController: RouteListViewController())
    private var bookmarkTab = UINavigationController(title: "Bookmark", defaultImage: "bookmark", selectedImage: "bookmark.fill", viewController: BookmarkViewController())
    private var settingTab  = UINavigationController(title: "Setting", defaultImage: "gearshape", selectedImage: "gearshape.fill", viewController: SettingViewController())
    
    override func viewDidLoad() {
        self.viewControllers = [routeTab, bookmarkTab, settingTab]
    }
}
