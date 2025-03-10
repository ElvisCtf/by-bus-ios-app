//
//  SplashScreenViewModel.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import RxSwift
import RxCocoa

final class SplashScreenViewModel {
    private let apiService: APIServiceProtocol
    
    let routesRelay = PublishRelay<[Route]>()
    
    init(apiServie: APIServiceProtocol = APIService()) {
        self.apiService = apiServie
    }
    
    func getRoutes() {
        apiService.getRoutes { [weak self] success, data, error in
            guard let self else { return }
            if success {
                if let data, let fetchedRoutes = data.routes {
                    routesRelay.accept(fetchedRoutes)
                }
            }
        }
    }
}
