//
//  UINavigationController+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 28/11/2024.
//

import UIKit

extension UINavigationController {
    convenience init(title: String, defaultImage: String, selectedImage: String, viewController: UIViewController) {
        self.init(rootViewController: viewController)
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: defaultImage), selectedImage: UIImage(systemName: selectedImage))
    }
}
