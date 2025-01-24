//
//  APIServiceProtocol.swift
//  ByBus
//
//  Created by Elvis Cheng (ESD - Software Trainee, Digital Solutions) on 21/1/2025.
//

protocol APIServiceProtocol: AnyObject {
    func getRouteList(completion: @escaping (Bool, RouteListResponseDto?, Error?) -> Void)
}

