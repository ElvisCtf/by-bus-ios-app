//
//  BookmarkViewModel.swift
//  ByBus
//
//  Created by Elvis Cheng on 17/3/2025.
//

import RxSwift
import RxCocoa
import Foundation

final class BookmarkViewModel {
    let reloadDataRelay = PublishRelay<Void>()
    let reloadRowRelay = PublishRelay<IndexPath>()
    
    var bookmarks = [BusStopBookmark]() {
        didSet {
            etas = Array(repeating: "", count: bookmarks.count)
            isExpanded = Array(repeating: false, count: bookmarks.count)
        }
    }
    var etas: [String] = []
    var isExpanded: [Bool] = []
    
    private let apiService: APIServiceProtocol
    private let dbService: DatabaseServiceProtocol
    
    init(apiServie: APIServiceProtocol = APIService(), dbService: DatabaseServiceProtocol = DatabaseService.shared) {
        self.apiService = apiServie
        self.dbService = dbService
    }
    
    func getBookmarks() {
        dbService.getBusStopBookmarks { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let bookmarks):
                self.bookmarks = bookmarks
                self.reloadDataRelay.accept(())
            case .failure(_):
                ()
            }
        }
    }
    
    func getEta(index: Int, stopID: String, routeNo: String) async {
        let result = await apiService.getEta(stopID: stopID, routeNo: routeNo)
        switch result {
        case .success(let data):
            if let etas = data.etas {
                let formattedEtas = etas.map { $0.time?.hhmm() ?? "" }
                self.etas[index] = "\n\(formattedEtas.joined(separator: "\n\n"))\n"
                self.reloadRowRelay.accept(IndexPath(row: 1, section: index))
            }
        case .failure(_):
            ()
        }
    }
}
