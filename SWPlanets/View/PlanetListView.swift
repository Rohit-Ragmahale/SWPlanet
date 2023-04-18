//
//  PlanetListView.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import SwiftUI

struct PlanetListView: View {
    @ObservedObject var planetListViewModel: PlanetListViewModel

    var body: some View {
        VStack {
            List{
                ForEach($planetListViewModel.planetList, id: \.self) { planet in
                    Text("\(planet.name.wrappedValue)")
                }
            }
            .listStyle(PlainListStyle())
            Spacer()
            NetworkStatusView(nonetworkStatusMessage: $planetListViewModel.networkStatusMessage, isOnline: $planetListViewModel.isOnline)
            
        }
        
    }
}

struct PlanetListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListView(
            planetListViewModel: PlanetListViewModel(serviceProvider:
                                                        AppDataServiceProvider(networkMonitor: NetworkMonitor.shared, online: OnlinePlanetService(), offliene: OfflinePlanetService()),
                                                     networkMonitor: NetworkMonitor.shared)
        )
    }
}
