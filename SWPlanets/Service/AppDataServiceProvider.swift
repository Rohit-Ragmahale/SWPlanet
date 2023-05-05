//
//  AppDataServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation
import CoreData

/// Online / Offline data service provider
///
/// ```
/// init(networkMonitor: NetworkMonitoring, online: DataServiceProvider)
/// ```
///
/// - Parameters
///     - networkMonitor: network status monitor
///     - online: Online data service
///
class AppDataServiceProvider: ServiceProvider {
    let networkMonitor: NetworkMonitoring
    let onlineServiceProvider: DataServiceProvider
    let coreDataManager = PersistenceManager.shared

    init(networkMonitor: NetworkMonitoring, online: DataServiceProvider) {
        self.networkMonitor = networkMonitor
        self.onlineServiceProvider = online
    }

    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?) -> Void)) {
        debugPrint("AppDataServiceProvider: \(networkMonitor.isConnected)")
        onlineServiceProvider.getPlanetList { planetList, serviceErrors in
            if let planetList = planetList {
                self.savePlanetList(planets: planetList.results)
            }
            completionHandler(planetList, serviceErrors)
        }
    }

    func savePlanetList(planets: [PlanetDetails]) {
        let workerContext = coreDataManager.persistentContainer.newBackgroundContext()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Planet.fetchRequest())
        _ = try? workerContext.execute(batchDeleteRequest)
        for planet in planets {
            let newPlanet = Planet(context: workerContext)
            newPlanet.name = planet.name
            newPlanet.terrain = planet.terrain
        }
        _ = try? workerContext.save()
    }
}
