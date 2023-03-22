//
//  NetworkingServiceFactory.swift
//  FactoryPatternServiceUITest
//
//  Created by Michelle Grover on 3/21/23.
//
import Foundation

class NetworkingServiceFactory {
    static func makeNetworkingService() -> NetworkingService {
        let session = URLSession.shared
        return AcronymNetworkingService(session: session)
    }
    static func makeMockNetworkingService() -> NetworkingService {
        return MockAcronymNetworkingService()
    }
}
