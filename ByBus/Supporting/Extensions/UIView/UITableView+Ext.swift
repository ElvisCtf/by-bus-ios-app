//
//  UITableView+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import UIKit

extension UITableView {
    static func plain(id: String = "", backgroundColor: UIColor = .clear, separateStyle: UITableViewCell.SeparatorStyle = .none) -> UITableView {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = backgroundColor
        tv.separatorStyle = .none
        tv.accessibilityIdentifier = id
        return tv
    }
}
