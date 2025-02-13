//
//  RouteListView.swift
//  ByBus
//
//  Created by Elvis Cheng on 9/12/2024.
//

import UIKit
import SnapKit
import RxSwift

final class RouteListView: UIView {
    static let name = "RouteListView"
    private let viewModel: RouteListViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        var tv = UITableView.plain(id: "\(Self.name)_table")
        tv.delegate = self
        tv.dataSource = self
        tv.register(RouteCellView.self, forCellReuseIdentifier: RouteCellView.reuseID)
        return tv
    }()
    
    private var routeList: [Route] {
        return viewModel.routeListObservable.value
    }
    
    init(with viewModel: RouteListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUI()
        setLayout()
        setBinding()
        viewModel.getRouteList()
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
    
    private func setBinding() {
        viewModel.routeListObservable
            .subscribe(onNext: { [weak self] list in
                guard let self else { return }
                self.tableView.reload()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Table View Delegate
extension RouteListView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RouteCellView.reuseID, for: indexPath) as! RouteCellView
        cell.setText(with: routeList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) selected")
    }
}
