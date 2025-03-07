//
//  RoutesViewModel.swift
//  ByBus
//
//  Created by Elvis Cheng on 11/2/2025.
//

import RxSwift
import RxCocoa

final class RoutesViewModel {
    let reloadDataRelay = PublishRelay<Void>()
    var displayRoutes = [Route]()
    
    private var routes = [Route]()
    private let apiService: APIServiceProtocol
    
    init(apiServie: APIServiceProtocol = APIService()) {
        self.apiService = apiServie
    }
    
    func getRoutes() {
        apiService.getRoutes { [weak self] success, data, error in
            guard let self else { return }
            if success {
                if let safeData = data, let fetchedRoutes = safeData.data {
                    self.routes = fetchedRoutes
                    self.displayRoutes = fetchedRoutes
                    self.reloadDataRelay.accept(())
                }
            }
        }
    }
    
    func filterRoutes(by searchingText: String, isSearchBarActive: Bool) {
        if searchingText.isEmpty || !isSearchBarActive {
            self.displayRoutes = routes
        } else {
            displayRoutes = routes.filter {
                if let routeNo = $0.routeNo {
                    return routeNo.lowercased().contains(searchingText.lowercased())
                }
                return false
            }
        }
        self.reloadDataRelay.accept(())
    }
}
