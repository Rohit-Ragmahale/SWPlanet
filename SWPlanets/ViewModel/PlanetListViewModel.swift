//
//  PlanetListViewModel.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

class PlanetListViewModel: ObservableObject {
    let serviceProvider: ServiceProvider
    @Published var planetList: [Planet] = [Planet(name: "Tatooine"), Planet(name: "Alderaan")]
    private let pageId: Int = 1

    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }

    func getPlanetData() {
        serviceProvider.getPlanetList(pageId: "\(pageId)") { planetList, error in
            if let planetList = planetList {
                DispatchQueue.main.async {
                    self.planetList = planetList.results
                }
            }
        }
    }
}
