//
//  DatabaseService.swift
//  ByBus
//
//  Created by Elvis Cheng on 11/3/2025.
//

import Foundation
import SwiftData

protocol DatabaseServiceProtocol: AnyObject {
    func saveBusStopBookmark(_ bookmark: BusStopBookmark)
    func deleteBusStopBookmark(_ bookmark: BusStopBookmark)
    func checkBusStopBookmark(stopID: String, routeNo: String, origin: TcEnSc, destination: TcEnSc) async -> Result<BusStopBookmark?, Error>
    func getBusStopBookmarks() async -> Result<[BusStopBookmark], Error>
}

final class DatabaseService: DatabaseServiceProtocol {
    static var shared = DatabaseService()
    var container: ModelContainer?
    var context: ModelContext?
    
    private init() {
        do {
            container = try ModelContainer(for: BusStopBookmark.self)
            if let container {
                context = ModelContext(container)
                context?.autosaveEnabled = true
            }
        } catch {
            print("Error initializing database container:", error)
        }
    }
    
    func saveBusStopBookmark(_ bookmark: BusStopBookmark) {
        if let context {
            context.insert(bookmark)
        }
    }
    
    func deleteBusStopBookmark(_ bookmark: BusStopBookmark) {
        if let context {
            context.delete(bookmark)
        }
    }
    
    func checkBusStopBookmark(stopID: String, routeNo: String, origin: TcEnSc, destination: TcEnSc) async -> Result<BusStopBookmark?, Error> {
        let descriptor = FetchDescriptor<BusStopBookmark>(predicate: #Predicate { bookmark in
            bookmark.stopID == stopID
            && bookmark.routeNo == routeNo
            && bookmark.origin.en == origin.en
            && bookmark.destination.en == destination.en
        })
        
        if let context {
            do {
                let bookmark = try context.fetch(descriptor)
                return .success(bookmark.first)
            } catch {
                return .failure(error)
            }
        } else {
            return .failure(NSError(domain: "Nil context", code: -1, userInfo: nil))
        }
    }
    
    func getBusStopBookmarks() async -> Result<[BusStopBookmark], Error> {
        let descriptor = FetchDescriptor<BusStopBookmark>()
        
        if let context {
            do {
                let data = try context.fetch(descriptor)
                return .success(data)
            } catch {
                return .failure(error)
            }
        } else {
            return .failure(NSError(domain: "Nil context", code: -1, userInfo: nil))
        }
    }
}
