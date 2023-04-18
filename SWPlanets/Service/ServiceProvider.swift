//
//  ServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

protocol DataServiceProvider {
    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?)-> Void))
}

protocol ServiceProvider: DataServiceProvider {
    func savePlanetList(planets: [PlanetDetails])
}

extension ServiceProvider {
    func savePlanetList(planets: [PlanetDetails]) {
        let workerContext = CoreDataStack.shared.newWorkerContext()
        Entity<Planet>.deleteAllObjectsOfType(predicate: nil, onContext: workerContext)
        for planetDetails in planets {
            if let planet: Planet = Entity<Planet>.create(onContext: workerContext) {
                planet.name = planetDetails.name
            }
        }
        CoreDataStack.shared.saveContext(context: workerContext)
    }
}

enum ServiceErrors: Error {
    case serviceError
    case dataDecodingError
}
