//
//  AppDataServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

/// Online / Offline data service provider
///
/// ```
/// init(networkMonitor: NetworkMonitoring, online: DataServiceProvider, offline: DataServiceProvider)
/// ```
///
/// - Parameters
///     - networkMonitor: network status monitor
///     - online: Online data service
///     - offline: Offline data service
///
class AppDataServiceProvider: ServiceProvider {
    let networkMonitor: NetworkMonitoring
    let onlineServiceProvider: DataServiceProvider
    let offlineServiceProvider: DataServiceProvider

    init(networkMonitor: NetworkMonitoring, online: DataServiceProvider, offline: DataServiceProvider) {
        self.networkMonitor = networkMonitor
        self.onlineServiceProvider = online
        self.offlineServiceProvider = offline
    }

    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?) -> Void)) {
        debugPrint("AppDataServiceProvider: \(networkMonitor.isConnected)")
        networkMonitor.isConnected ?
        onlineServiceProvider.getPlanetList(completionHandler: completionHandler) :
        offlineServiceProvider.getPlanetList(completionHandler: completionHandler)
    }
}
