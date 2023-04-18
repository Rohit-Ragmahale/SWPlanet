//
//  AppContentView.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import SwiftUI

struct AppContentView: View {
    @ObservedObject var planetListViewModel: PlanetListViewModel
    
    var body: some View {
        VStack {
            if planetListViewModel.isNetworkLoadingData {
                LoadingView(tintColor: .black, scaleSize: 2.0).padding(.bottom,50)
            } else {
                PlanetListView(planetListViewModel: planetListViewModel)
            }
        }
        .padding()
        .onAppear {
            planetListViewModel.startNetworkObservation()
            planetListViewModel.getPlanetData()
        }
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView(planetListViewModel: PlanetListViewModel(serviceProvider: OnlinePlanetServiceProvider.shared, offlineServiceProvider: OfflinePlanetServiceProvider.shared, networkMonitor: NetworkMonitor.shared))
    }
}
