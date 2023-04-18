//
//  OfflineServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation
import CoreData

struct OfflinePlanetServiceProvider: ServiceProvider {
    static let shared =  OfflinePlanetServiceProvider()
     
    private init() {}

    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?) -> Void)) {
        let list = Entity<Planet>.fetch(onContext: CoreDataStack.shared.mainContext())
        let planetDetailsList = list.map { planet in
            PlanetDetails(name: planet.name ?? "")
        }
        completionHandler(PlanetList(results: planetDetailsList), nil)
    }
}