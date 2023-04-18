//
//  PlanetListViewModel.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

class PlanetListViewModel: ObservableObject {
    let serviceProvider: ServiceProvider
    let offlineServiceProvider: ServiceProvider
    let networkMonitor: NetworkMonitoring
    
    @Published var isNetworkLoadingData: Bool = false
    @Published var planetList: [Planet] = []
    @Published var isOnline: Bool = false

    init(serviceProvider: ServiceProvider, offlineServiceProvider: ServiceProvider, networkMonitor: NetworkMonitoring) {
        self.offlineServiceProvider = offlineServiceProvider
        self.serviceProvider = serviceProvider
        self.networkMonitor = networkMonitor
        self.isOnline = networkMonitor.isConnected
    }

    @objc func networkStatusUpdated() {
        DispatchQueue.main.async {
            if self.isOnline != self.networkMonitor.isConnected {
                self.isOnline = self.networkMonitor.isConnected
                self.getPlanetData()
            }
            
        }
    }

    func startNetworkObservation() {
        networkMonitor.startMonitoring()
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusUpdated), name: .networkConnectivityStatus, object: nil)
    }
    
    func getPlanetData() {
        isNetworkLoadingData = true
        let completionHandler: ((PlanetList?, ServiceErrors?) -> Void)  = { planetList, error in
            if let planetList = planetList {
                DispatchQueue.main.async {
                    self.isNetworkLoadingData = false
                    self.planetList = planetList.results
                }
            }
        }
    
        isOnline ? serviceProvider.getPlanetList(completionHandler: completionHandler) : offlineServiceProvider.getPlanetList(completionHandler: completionHandler)
    }
    
    deinit {
        networkMonitor.stopMonitoring()
        NotificationCenter.default.removeObserver(self)
    }
}
