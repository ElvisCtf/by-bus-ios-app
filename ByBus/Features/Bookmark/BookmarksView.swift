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
        var tv = UITableView.plain(id: "\(Self.name)_table", backgroundColor: .systemGroupedBackground)
        tv.delegate = self
        tv.dataSource = self
        tv.register(BookmarkCellView.self, forCellReuseIdentifier: BookmarkCellView.reuseID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let bookmark = viewModel.bookmarks[row]
        let eta = viewModel.etas[row]
        let isExpanded = viewModel.isExpanded[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCellView.reuseID, for: indexPath) as! BookmarkCellView
        cell.setText(with: bookmark, eta: eta, isExpanded: isExpanded)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        viewModel.isExpanded[row].toggle()
        let bookmark = viewModel.bookmarks[row]
        if viewModel.isExpanded[indexPath.row] {
            Task {
                await viewModel.getEta(index: indexPath.row, stopID: bookmark.stopID, routeNo: bookmark.routeNo)
            }
        } else {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
