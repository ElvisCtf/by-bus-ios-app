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
    var direction: Direction = .outbound
    
    private let busStopRelay = PublishRelay<BusStop>()
    private var busStopsCount = 0
    
    private let apiService: APIServiceProtocol
    private let dbService: DatabaseServiceProtocol
    
    private let disposeBag = DisposeBag()
    
    init(apiService: APIServiceProtocol = APIService(), dbService: DatabaseServiceProtocol = DatabaseService.shared) {
        self.apiService = apiService
        self.dbService = dbService
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
    
    func getBusStops(no: String) {
        busStops = []
        apiService.getRouteStops(no: no, direction: direction.value) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                let routeStops = data.routeStops ?? []
                self.busStopsCount = routeStops.count
                for routeStop in routeStops {
                    if let id = routeStop.id,
                       let index = routeStop.sequence {
                        apiService.getStop(id: id, index: index) { result in
                            switch result {
                            case .success(let data):
                                if let stop = data.0.stop {
                                    self.busStopRelay.accept(BusStop(index: index, routeNo: no, stop: stop))
                                }
                            case .failure(_):
                                ()
                            }
                        }
                    }
                }
            case .failure(_):
                ()
            }
        }
    }
    
    func getEta(index: Int, stopID: String, routeNo: String) {
        apiService.getEta(stopID: stopID, routeNo: routeNo) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                if let etas = data.etas {
                    self.busStops[index].etas = etas.map { $0.time?.hhmm() ?? "" }
                    self.reloadRowRelay.accept(IndexPath(row: 1, section: index))
                }
            case .failure(_):
                ()
            }
        }
    }
    
    func saveBookmark(id stopID: String, routeNo: String, origin: TcEnSc, destination: TcEnSc) {
        dbService.checkBusStopBookmark(stopID: stopID, routeNo: routeNo, origin: origin, destination: destination) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let bookmark):
                if let bookmark {
                    self.deleteBookmark(bookmark)
                } else {
                    self.dbService.saveBusStopBookmark(BusStopBookmark(stopID: stopID, routeNo: routeNo, origin: origin, destination: destination))
                }
            case .failure(_):
                ()
            }
        }
    }
    
    func deleteBookmark(_ bookmark: BusStopBookmark) {
        dbService.deleteBusStopBookmark(bookmark)
    }
    
    func switchDirection() {
        direction = direction.toggle
    }
}
