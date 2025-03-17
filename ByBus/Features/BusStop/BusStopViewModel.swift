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
    
    private let apiService: APIServiceProtocol
    private let dbService: DatabaseServiceProtocol
    
    private let disposeBag = DisposeBag()
    
    init(apiService: APIServiceProtocol = APIService(), dbService: DatabaseServiceProtocol = DatabaseService.shared) {
        self.apiService = apiService
        self.dbService = dbService
    }
    
    func switchDirection() {
        direction = direction.toggle
    }
}


// MARK: - API
extension BusStopViewModel {
    func getBusStops(no: String) async {
        busStops = []
        switch await apiService.getRouteStops(no: no, direction: direction.value) {
        case .success(let data):
            let routeStops = data.routeStops ?? []
            self.busStops = await getBusStopDetails(with: routeStops, routeNo: no)
            self.reloadDataRelay.accept(())
        case .failure(_):
            ()
        }
    }
    
    private func getBusStopDetails(with routeStops: [RouteStop], routeNo: String) async -> [BusStop] {
        var fetchedBusStops = [BusStop]()
        for routeStop in routeStops {
            if let id = routeStop.id, let index = routeStop.sequence {
                switch await apiService.getStop(id: id, index: index) {
                case .success(let data):
                    if let stop = data.stop, let index = routeStop.sequence {
                        fetchedBusStops.append(BusStop(index: index, routeNo: routeNo, stop: stop))
                    }
                case .failure(_):
                    ()
                }
            }
        }
        
        return fetchedBusStops
    }
    
    func getEta(index: Int, stopID: String, routeNo: String) async {
        let result = await apiService.getEta(stopID: stopID, routeNo: routeNo)
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


// MARK: - Database
extension BusStopViewModel {
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
}
