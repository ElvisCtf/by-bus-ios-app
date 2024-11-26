//
//  TabBarController.swift
//  ByBus
//
//  Created by Elvis Cheng on 26/11/2024.
//

import UIKit

class TabBarController: UITabBarController {
    lazy var routeTab = RouteTab
    lazy var bookmarkTab = BookmarkTab
    lazy var settingTab = SettingTab
    
    override func viewDidLoad() {
        self.viewControllers = [routeTab, bookmarkTab, settingTab]
    }
}


// MARK: - UI
extension TabBarController: UITabBarControllerDelegate {
    var RouteTab: UINavigationController {
        return buildTab(title: "Route", defaultImage: "bus", selectedImage: "bus.fill", viewController: RouteViewController())
    }
    
    var BookmarkTab: UINavigationController {
        return buildTab(title: "Bookmark", defaultImage: "bookmark", selectedImage: "bookmark.fill", viewController: BookmarkViewController())
    }
    
    var SettingTab: UINavigationController {
        return buildTab(title: "Setting", defaultImage: "gearshape", selectedImage: "gearshape.fill", viewController: SettingViewController())
    }
    
    private func buildTab(title: String, defaultImage: String, selectedImage: String, viewController: UIViewController) -> UINavigationController {
        let controller = UINavigationController(rootViewController: viewController)
        let defaultImage = UIImage(systemName: defaultImage)
        let selectedImage = UIImage(systemName: selectedImage)
        let tabBarItems = (title: title, image: defaultImage, selectedImage: selectedImage)
        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        controller.tabBarItem = tabBarItem
        return controller
    }
}
