//
//  BookmarksViewController.swift
//  ByBus
//
//  Created by Elvis Cheng on 26/11/2024.
//

import UIKit

class BookmarksViewController: UIViewController {
    private let viewModel = BookmarksViewModel()
    private lazy var bookmarkView = BookmarksView(with: viewModel)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            await viewModel.getBookmarks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        title = "收藏"
        view = bookmarkView
    }
}
