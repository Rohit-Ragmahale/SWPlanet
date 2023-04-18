//
//  OfflineServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation
import CoreData

struct OfflinePlanetService: DataServiceProvider {
 
    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?) -> Void)) {
        debugPrint("Fetching list from Offline Service Provider")
        let list = Entity<Planet>.fetch(onContext: CoreDataStack.shared.mainContext())
        let planetDetailsList = list.map { planet in
            PlanetDetails(name: planet.name ?? "")
        }
        completionHandler(PlanetList(results: planetDetailsList), nil)
    }
}
