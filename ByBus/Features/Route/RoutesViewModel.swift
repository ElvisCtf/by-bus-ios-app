//
//  RoutesViewModel.swift
//  ByBus
//
//  Created by Elvis Cheng on 11/2/2025.
//

import RxSwift
import RxCocoa

final class RoutesViewModel {
    private var routes: [Route]
    private let apiService: APIServiceProtocol
    
    let reloadDataRelay = PublishRelay<Void>()
    var displayRoutes = [Route]()
    
    
    init(routes: [Route], apiServie: APIServiceProtocol = APIService()) {
        self.routes = routes
        self.displayRoutes = routes
        self.apiService = apiServie
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
    
    func getRoutes() async {
        let result = await apiService.getRoutes()
        switch result {
        case .success(let data):
            if let fetchedRoutes = data.routes {
                self.routes = fetchedRoutes
                self.displayRoutes = fetchedRoutes
                self.reloadDataRelay.accept(())
            }
        case .failure(_):
            ()
        }
    }
}
