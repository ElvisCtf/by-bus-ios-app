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
        apiService.getRoutes { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                if let fetchedRoutes = data.routes {
                    routesRelay.accept(fetchedRoutes)
                }
            case .failure(_):
                ()
            }
        }
    }
}
