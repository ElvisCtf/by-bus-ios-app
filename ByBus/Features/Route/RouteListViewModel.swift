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
    
    private let apiService: APIService
    
    init(apiServie: APIService = APIService()) {
        self.apiService = apiServie
    }
    
    func getRouteList() {
        apiService.getRouteList { [weak self] success, data, error in
            guard let self else { return }
            if success {
                if let safeData = data, let routeList = safeData.data {
                    self.routeListObservable.accept(routeList)
                }
            }
            
        }
    }
}
