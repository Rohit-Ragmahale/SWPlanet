//
//  ServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation


protocol ServiceProvider {
    func getPlanetList(pageId: String, completionHandler: @escaping ((PlanetList?, ServiceErrors?)-> Void))
}

enum ServiceErrors: Error {
    case serviceError
    case dataDecodingError
}
