//
//  MockNetworkMonitor.swift
//  SWPlanetsTests
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation


class MockNetworkMonitor: NetworkMonitoring {
    
    var monitoringStarted = false
    
    var isConnected: Bool = false
    
    var statusMesssage: String = ""

    
    func stopMonitoring() {
        monitoringStarted = false
    }
    
    func startMonitoring() {
        monitoringStarted = true
    }
    
}
