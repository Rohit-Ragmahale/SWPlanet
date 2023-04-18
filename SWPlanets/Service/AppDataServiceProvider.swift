//
//  AppDataServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

class AppDataServiceProvider: ServiceProvider {
    let networkMonitor: NetworkMonitoring
    let onlineServiceProvider: DataServiceProvider
    let offlineServiceProvider: DataServiceProvider

    init(networkMonitor: NetworkMonitoring, online: DataServiceProvider, offliene: DataServiceProvider) {
        self.networkMonitor = networkMonitor
        self.onlineServiceProvider = online
        self.offlineServiceProvider = offliene
    }

    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?) -> Void)) {
        networkMonitor.isConnected ?
        onlineServiceProvider.getPlanetList(completionHandler: completionHandler) :
        offlineServiceProvider.getPlanetList(completionHandler: completionHandler)
    }
}
