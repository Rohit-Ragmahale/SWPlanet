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
            Spacer()
            if planetListViewModel.isNetworkLoadingData {
                LoadingView(tintColor: .black, scaleSize: 2.0).padding(.bottom,50)
            } else {
                PlanetListView()
            }
            Spacer()
            NetworkStatusView()
        }
        .padding()
        .onAppear {
            planetListViewModel.viewDidAppear()
        }
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView(planetListViewModel: PlanetListViewModel(serviceProvider: AppDataServiceProvider(networkMonitor: NetworkMonitor.shared, online: OnlinePlanetService()), networkMonitor: NetworkMonitor.shared))
    }
}
