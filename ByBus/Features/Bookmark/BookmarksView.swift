//
//  BookmarksView.swift
//  ByBus
//
//  Created by Elvis Cheng on 17/3/2025.
//

import UIKit
import SnapKit
import RxSwift

final class BookmarksView: UIView {
    static let name = "BookmarkView"
    private let viewModel: BookmarksViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        var tv = UITableView.plain(id: "\(Self.name)_table")
        tv.delegate = self
        tv.dataSource = self
        tv.register(RouteCellView.self, forCellReuseIdentifier: RouteCellView.reuseID)
        tv.register(ExpandedCellView.self, forCellReuseIdentifier: ExpandedCellView.reuseID)
        return tv
    }()
    
    init(with viewModel: BookmarksViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUI()
        setLayout()
        setBinding()
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
        viewModel.reloadDataRelay.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.reloadRowRelay.asSignal()
            .emit(onNext: { [weak self] indexPath in
                guard let self else { return }
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Table View Delegate
extension BookmarksView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookmark = viewModel.bookmarks[indexPath.section]
        
        if indexPath.row == 0 {
            // header cell
            let cell = tableView.dequeueReusableCell(withIdentifier: RouteCellView.reuseID, for: indexPath) as! RouteCellView
            cell.setText(with: bookmark)
            return cell
        } else {
            // expandable cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandedCellView.reuseID, for: indexPath) as! ExpandedCellView
            cell.setText(viewModel.etas[indexPath.section], isExpanded: viewModel.isExpanded[indexPath.section])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let childIndexPath = IndexPath(row: 1, section: indexPath.section)
        if indexPath.row == 0 {
            viewModel.isExpanded[indexPath.section].toggle()
            let bookmark = viewModel.bookmarks[indexPath.section]
            if viewModel.isExpanded[indexPath.section] {
                Task {
                    await viewModel.getEta(index: indexPath.section, stopID: bookmark.stopID, routeNo: bookmark.routeNo)
                }
            } else {
                tableView.reloadRows(at: [childIndexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isExpanded = viewModel.isExpanded[indexPath.section]
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        }
        return isExpanded ? UITableView.automaticDimension : 0
    }
}
