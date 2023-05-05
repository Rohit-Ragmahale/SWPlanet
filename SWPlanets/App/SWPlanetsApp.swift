//
//  SWPlanetsApp.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import SwiftUI

@main
struct SWPlanetsApp: App {
    let persistenceManager = PersistenceManager.shared
    var body: some Scene {
        WindowGroup {
            AppContentView(planetListViewModel:
                            PlanetListViewModel(serviceProvider:
                                                    AppDataServiceProvider(networkMonitor:NetworkMonitor.shared,
                                                                           online: OnlinePlanetService()),
                                                networkMonitor: NetworkMonitor.shared)
            )
            .environment(
                \.managedObjectContext,
                persistenceManager.persistentContainer.viewContext)
            .environmentObject(NetworkMonitor.shared)
        }
    }
}
