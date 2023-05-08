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

enum ServiceErrors: Error {
    case serviceError
    case dataError
    case dataDecodingError
}
