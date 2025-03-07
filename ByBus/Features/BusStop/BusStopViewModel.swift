//
//  BusStopViewModel.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

import RxSwift
import RxCocoa
import Foundation

final class BusStopViewModel {
    let reloadDataRelay = PublishRelay<Void>()
    var busStops = [BusStop]()
    
    private let busStopRelay = PublishRelay<BusStop>()
    private var busStopsCount = 0
    private let apiService: APIServiceProtocol
    private let disposeBag = DisposeBag()
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        setBinding()
    }
    
    private func setBinding() {
        busStopRelay
            .subscribe(onNext: { [weak self] busStop in
                guard let self else { return }
                busStops.append(busStop)
                if busStops.count == busStopsCount {
                    busStops.sort {
                        $0.index < $1.index
                    }
                    reloadDataRelay.accept(())
                }
            }).disposed(by: disposeBag)
    }
    
    func getBusStops(no: String, direction: Direction) {
        busStops = []
        apiService.getRouteStops(no: no, direction: direction.value) { [weak self] success, data, error in
            guard let self else { return }
            if success, let data, let routeStops = data.routeStops {
                self.busStopsCount = routeStops.count
                for routeStop in routeStops {
                    if let id = routeStop.id,
                       let index = routeStop.sequence {
                        apiService.getStop(id: id, index: index) { success, data, index, error in
                            if success, let data, let name = data.stop?.nameTc {
                                self.busStopRelay.accept(BusStop(index: index, name: name))
                            }
                        }
                    }
                }
            }
        }
    }
}
