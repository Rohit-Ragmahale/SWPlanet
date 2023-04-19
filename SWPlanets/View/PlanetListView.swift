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
            HStack {
                Text("Star War Planet List")
                    .font(.headline)
            }
            if $planetListViewModel.planetList.isEmpty {
                Text("No data found!\nPlease check your network connection and try again.")
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .font(.title2)
                    
            } else {
                List{
                    ForEach($planetListViewModel.planetList, id: \.self) { planet in
                        Text("\(planet.name.wrappedValue)")
                            .padding(10)
                            .font(.title2)
                    }
                }.listStyle(PlainListStyle())
            }
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
