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
    var networkStatusIsConnected: Bool = false

    init(serviceProvider: ServiceProvider, networkMonitor: NetworkMonitoring) {
        self.dataProvider = serviceProvider
        self.networkMonitor = networkMonitor
        self.networkStatusIsConnected = networkMonitor.isConnected
    }

    @objc func networkStatusUpdated() {
        DispatchQueue.main.async {
            if self.networkStatusIsConnected != self.networkMonitor.isConnected {
                debugPrint("Status Change Detected")
                self.networkStatusIsConnected = self.networkMonitor.isConnected
                self.getPlanetData()
            }
        }
    }

    func viewDidAppear() {
        startNetworkObservation()
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
            }
        })
    }
    
    deinit {
        networkMonitor.stopMonitoring()
        NotificationCenter.default.removeObserver(self)
    }
}
