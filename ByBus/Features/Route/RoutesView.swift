//
//  RoutesView.swift
//  ByBus
//
//  Created by Elvis Cheng on 9/12/2024.
//

import UIKit
import SnapKit
import RxSwift

final class RoutesView: UIView {
    static let name = "Routes"
    private let viewModel: RoutesViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        var tv = UITableView.plain(id: "\(Self.name)_table")
        tv.delegate = self
        tv.dataSource = self
        tv.register(RouteCellView.self, forCellReuseIdentifier: RouteCellView.reuseID)
        return tv
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.keyboardType = .asciiCapable
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = ""
        return controller
    }()
    
    weak var parentVC: UIViewController?
    
    init(parentVC: UIViewController, with viewModel: RoutesViewModel) {
        self.parentVC = parentVC
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUI()
        setLayout()
        setBinding()
        viewModel.getRoutes()
    }
    
    private func setUI() {
        backgroundColor = .systemBackground
        parentVC?.navigationItem.searchController = searchController
    }
    
    private func setLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
    }
    
    private func setBinding() {
        viewModel.reloadDataRelay.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Table View Delegate
extension RoutesView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RouteCellView.reuseID, for: indexPath) as! RouteCellView
        cell.setText(with: viewModel.displayRoutes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let busStopVC = BusStopViewController(route: viewModel.displayRoutes[indexPath.row])
        parentVC?.navigationController?.pushViewController(busStopVC, animated: true)
    }
}


// MARK: - UISearchController Delegate
extension RoutesView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchingText = searchController.searchBar.text {
            viewModel.filterRoutes(by: searchingText, isSearchBarActive: searchController.isActive)
        }
    }
}
