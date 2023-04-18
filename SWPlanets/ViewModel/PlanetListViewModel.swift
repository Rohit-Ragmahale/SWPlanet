//
//  PlanetListViewModel.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

class PlanetListViewModel: ObservableObject {
    @Published var planetList: [Planet] = [Planet(name: "Tatooine"), Planet(name: "Alderaan")]
    
}
