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
    
    func getRoutes() async {
        let result = await apiService.getRoutes()
        switch result {
        case .success(let data):
            if let fetchedRoutes = data.routes {
                routesRelay.accept(fetchedRoutes)
            }
        case .failure:
            ()
        }
    }
}
