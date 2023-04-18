//
//  ServiceProviderMock.swift
//  SWPlanetsTests
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

class MockAppDataServiceProvider: ServiceProvider {
    var isOnline = false
    let online: MockOnlineService
    let offLine: MockOfflineService
    
    init(isOnline: Bool = false, online: MockOnlineService, offLine: MockOfflineService) {
        self.isOnline = isOnline
        self.online = online
        self.offLine = offLine
    }
    
    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?) -> Void)) {
        isOnline ? online.getPlanetList(completionHandler: completionHandler) : offLine.getPlanetList(completionHandler: completionHandler)
    }
    
    func savePlanetList(planets: [PlanetDetails]) {
        isOnline ? online.savePlanetList(planets: planets) : offLine.savePlanetList(planets: planets)
    }
}

class MockOnlineService: DataServiceProvider {
    
    var onlineDataSaved = false
    
    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?) -> Void)) {
        completionHandler(PlanetList(results: [PlanetDetails(name: "OnlinePlanet"), PlanetDetails(name: "OnlinePlanet 2")]), nil)
    }
    
    func savePlanetList(planets: [PlanetDetails]) {
        self.onlineDataSaved = true
    }
}

class MockOfflineService: DataServiceProvider {
    var offlineDataSaved = false
    
    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?) -> Void)) {
        completionHandler(PlanetList(results: [PlanetDetails(name: "OfflinePlanet")]), nil)
    }
    
    func savePlanetList(planets: [PlanetDetails]) {
        self.offlineDataSaved = true
    }
}
