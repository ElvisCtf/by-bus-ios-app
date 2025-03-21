//
//  BusStopsViewModel.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

import RxSwift
import RxCocoa
import Foundation

final class BusStopsViewModel {
    let reloadDataRelay = PublishRelay<Void>()
    let reloadRowRelay = PublishRelay<IndexPath>()
    
    var route: Route
    var busStops = [BusStop]()
    var direction: Direction = .outbound
    
    private let apiService: APIServiceProtocol
    private let dbService: DatabaseServiceProtocol
    
    private let disposeBag = DisposeBag()
    
    init(apiService: APIServiceProtocol = APIService(), dbService: DatabaseServiceProtocol = DatabaseService.shared, with route: Route) {
        self.apiService = apiService
        self.dbService = dbService
        self.route = route
    }
    
    func switchDirection() {
        route.switchDirection()
        direction = direction.toggle
    }
}


// MARK: - API
extension BusStopsViewModel {
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
        return await withTaskGroup(of: (Int, Result<StopResponseDto, Error>).self, returning: [BusStop].self) { taskGroup in
            var fetchedBusStops: [BusStop] = []
            
            for routeStop in routeStops {
                if let id = routeStop.id, let index = routeStop.sequence {
                    taskGroup.addTask {
                        await self.apiService.getStop(id: id, index: index)
                    }
                }
            }
            
            for await result in taskGroup {
                let (index, dto) = result
                switch dto {
                case .success(let data):
                    if let stop = data.stop {
                        let isSaved = await checkSaved(id: stop.id ?? "", routeNo: routeNo, origin: route.origin, destination: route.destination)
                        fetchedBusStops.append(BusStop(index: index, routeNo: routeNo, stop: stop, isSaved: isSaved))
                    }
                case .failure(_):
                    ()
                }
            }
            fetchedBusStops.sort { $0.index < $1.index }
            return fetchedBusStops
        }
    }
    
    func getEta(index: Int, stopID: String, routeNo: String) async {
        let result = await apiService.getEta(stopID: stopID, routeNo: routeNo)
        switch result {
        case .success(let data):
            if let etas = data.etas {
                self.busStops[index].etas = etas.map { $0.time?.hhmm() ?? "" }
                self.reloadRowRelay.accept(IndexPath(row: index, section: 0))
            }
        case .failure(_):
            ()
        }
    }
}


// MARK: - Database
extension BusStopsViewModel {
    func checkSaved(id stopID: String, routeNo: String, origin: TcEnSc, destination: TcEnSc) async -> Bool {
        let result = await dbService.checkBusStopBookmark(stopID: stopID, routeNo: routeNo, origin: origin, destination: destination)
        switch result {
        case .success(let bookmark):
            return bookmark != nil
        case .failure(_):
            return false
        }
    }
    
    func saveBookmark(id stopID: String, routeNo: String, name: TcEnSc, origin: TcEnSc, destination: TcEnSc) async {
        let result = await dbService.checkBusStopBookmark(stopID: stopID, routeNo: routeNo, origin: origin, destination: destination)
        switch result {
        case .success(let bookmark):
            if let bookmark {
                self.deleteBookmark(bookmark)
            } else {
                self.dbService.saveBusStopBookmark(BusStopBookmark(stopID: stopID, routeNo: routeNo, origin: origin, destination: destination, name: name))
            }
        case .failure(_):
            ()
        }
    }
    
    func deleteBookmark(_ bookmark: BusStopBookmark) {
        dbService.deleteBusStopBookmark(bookmark)
    }
}
