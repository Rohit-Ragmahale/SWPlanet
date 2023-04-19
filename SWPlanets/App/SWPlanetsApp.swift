//
//  SWPlanetsApp.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import SwiftUI

@main
struct SWPlanetsApp: App {
    var body: some Scene {
        WindowGroup {
            AppContentView(planetListViewModel:
                            PlanetListViewModel(serviceProvider:
                                                    AppDataServiceProvider(networkMonitor:NetworkMonitor.shared,
                                                                           online: OnlinePlanetService(),
                                                                           offline: OfflinePlanetService()),
                                                networkMonitor: NetworkMonitor.shared)
            )
        }
    }
}
