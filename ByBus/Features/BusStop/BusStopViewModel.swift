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
    let reloadRowRelay = PublishRelay<IndexPath>()
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
                            if success, let data, let stop = data.stop {
                                self.busStopRelay.accept(BusStop(index: index, routeNo: no, stop: stop))
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getEta(index: Int, stopID: String, routeNo: String) {
        apiService.getEta(stopID: stopID, routeNo: routeNo) { [weak self] success, data, error in
            guard let self else { return }
            if success, let data, let etas = data.etas {
                self.busStops[index].etas = etas.map { $0.time?.hhmm() ?? "" }
                self.reloadRowRelay.accept(IndexPath(row: 1, section: index))
            }
        }
    }
}
