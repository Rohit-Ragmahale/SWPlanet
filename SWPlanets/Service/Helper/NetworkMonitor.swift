//
//  NetworkMonitor.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Network
import Foundation

protocol NetworkMonitoring {
    func startMonitoring()
    func stopMonitoring()
    var isConnected: Bool {get}
}


extension Notification.Name {
    static let networkConnectivityStatus = Notification.Name(rawValue: "networkConnectivityStatusChanged")
}

let isConnectedStatusKey = "isConnected"

final class NetworkMonitor: NetworkMonitoring {
    static let shared = NetworkMonitor()

    private let monitoringQueue = DispatchQueue(label: "NetworkConnectivityMonitorQueue")
    private let monitor: NWPathMonitor
    private(set) var isConnected = false

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = {[weak self] newPath in
            self?.isConnected = newPath.status != .unsatisfied
            print("network status changed \(self?.isConnected)")
            NotificationCenter.default.post(name: .networkConnectivityStatus, object: nil )
        }
        monitor.start(queue: monitoringQueue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    deinit {
        stopMonitoring()
    }
}
    
