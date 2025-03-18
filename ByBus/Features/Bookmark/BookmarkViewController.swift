//
//  BookmarkViewController.swift
//  ByBus
//
//  Created by Elvis Cheng on 26/11/2024.
//

import UIKit

class BookmarkViewController: UIViewController {
    private let viewModel = BookmarkViewModel()
    private lazy var bookmarkView = BookmarkView(with: viewModel)
    
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
