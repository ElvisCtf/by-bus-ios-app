//
//  RouteListViewModel.swift
//  ByBus
//
//  Created by Elvis Cheng on 11/2/2025.
//

import RxSwift
import RxCocoa

final class RouteListViewModel {
    let routeListObservable = BehaviorRelay<[Route]>.init(value: [])
    private var routeList = [Route]()
    private var filteredRouteList = [Route]()
    private let apiService: APIServiceProtocol
    
    init(apiServie: APIServiceProtocol = APIService()) {
        self.apiService = apiServie
    }
    
    func getRouteList() {
        apiService.getRouteList { [weak self] success, data, error in
            guard let self else { return }
            if success {
                if let safeData = data, let fetchedRouteList = safeData.data {
                    self.routeList = fetchedRouteList
                    self.routeListObservable.accept(self.routeList)
                }
            }
            
        }
    }
    
    func filterRouteList(by searchingText: String, isSearchBarActive: Bool) {
        if searchingText.isEmpty || !isSearchBarActive {
            self.routeListObservable.accept(routeList)
            return
        }
        
        filteredRouteList = routeList.filter {
            if let routeNo = $0.routeNo {
                return routeNo.lowercased().contains(searchingText.lowercased())
            }
            return false
        }
        self.routeListObservable.accept(filteredRouteList)
    }
    
    func getRoute(_ index: Int) -> Route {
        return routeListObservable.value[index]
    }
}
