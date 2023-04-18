//
//  OfflineServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

struct OfflinePlanetServiceProvider: ServiceProvider {
    static let shared =  OfflinePlanetServiceProvider()

    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?) -> Void)) {
        completionHandler(PlanetList(results: [Planet(name: "Tatooine"), Planet(name: "Tatooine2"), Planet(name: "Tatooine3")]), nil)
    }
}
