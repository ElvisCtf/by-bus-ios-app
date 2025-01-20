//
//  RouteListView.swift
//  ByBus
//
//  Created by Elvis Cheng on 9/12/2024.
//

import UIKit
import SnapKit

final class RouteListView: UIView {
    static let name = "RouteListView"
    
    private lazy var tableView: UITableView = {
        var tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.register(RouteCellView.self, forCellReuseIdentifier: RouteCellView.reuseID)
        tv.accessibilityIdentifier = "\(Self.name)_table"
        return tv
    }()
    
    init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        backgroundColor = .systemBackground
    }
    
    private func setLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
}


// MARK: - Table View Delegate
extension RouteListView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RouteCellView.reuseID, for: indexPath) as! RouteCellView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) selected")
    }
}
