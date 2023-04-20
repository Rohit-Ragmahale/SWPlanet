//
//  PlanetListViewModel.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

/// ViewModel for Planet list view
///
/// ```
/// init(serviceProvider: ServiceProvider, networkMonitor: NetworkMonitoring)
/// ```
///
/// - Parameters
///     - serviceProvider: online/offline data provider service
///     - networkMonitor: network status monitor
///
class PlanetListViewModel: ObservableObject {
    private let dataProvider: ServiceProvider
    private let networkMonitor: NetworkMonitoring
    
    @Published var isNetworkLoadingData: Bool = false
    @Published var planetList: [PlanetDetails] = []
    @Published var isOnline: Bool = false
    @Published var networkStatusMessage: String = ""

    init(serviceProvider: ServiceProvider, networkMonitor: NetworkMonitoring) {
        self.dataProvider = serviceProvider
        self.networkMonitor = networkMonitor
        self.isOnline = networkMonitor.isConnected
        self.networkStatusMessage = networkMonitor.statusMesssage
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

    func viewDidAppear() {
        startNetworkObservation()
        getPlanetData()
    }

    private func startNetworkObservation() {
        networkMonitor.startMonitoring()
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusUpdated), name: .networkConnectivityStatus, object: nil)
    }

    private func getPlanetData() {
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
