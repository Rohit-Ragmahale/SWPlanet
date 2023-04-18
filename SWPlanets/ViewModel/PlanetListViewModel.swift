//
//  PlanetListViewModel.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

class PlanetListViewModel: ObservableObject {
    let dataProvider: ServiceProvider
    let networkMonitor: NetworkMonitoring
    
    @Published var isNetworkLoadingData: Bool = false
    @Published var planetList: [PlanetDetails] = []
    @Published var isOnline: Bool = false
    @Published var networkStatusMessage: String = ""

    init(serviceProvider: ServiceProvider, networkMonitor: NetworkMonitoring) {
        self.dataProvider = serviceProvider
        self.networkMonitor = networkMonitor
        self.isOnline = networkMonitor.isConnected
    }

    @objc func networkStatusUpdated() {
        DispatchQueue.main.async {
            if self.isOnline != self.networkMonitor.isConnected {
                debugPrint("Status Change Detected")
                self.isOnline = self.networkMonitor.isConnected
                self.networkStatusMessage = self.networkMonitor.statusMesssage
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
        dataProvider.getPlanetList(completionHandler: { planetList, error in
            DispatchQueue.main.async {
                self.isNetworkLoadingData = false
                if let planetList = planetList {
                    self.planetList = planetList.results
                    if self.isOnline {
                        self.dataProvider.savePlanetList(planets: self.planetList)
                    }
                }
            }
        })
    }
    
    deinit {
        networkMonitor.stopMonitoring()
        NotificationCenter.default.removeObserver(self)
    }
}
