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
    var statusMesssage: String {get}
}

extension NWPath.UnsatisfiedReason {
    func description() -> String {
        switch self {
        case .notAvailable:
            return "No reason is given"

        case .cellularDenied:
            return "The user has disabled cellular"

        case .wifiDenied:
            return "The user has disabled Wi-Fi"

        case .localNetworkDenied:
            return "The user has disabled local network access"

        @unknown default:
            return "Offline"
        }
    }
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
    private(set)var statusMesssage: String = ""

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = {[weak self] newPath in
            self?.isConnected = newPath.status == .satisfied
            self?.statusMesssage = newPath.unsatisfiedReason.description()
            debugPrint("Network status changed : \(newPath.status)")
            debugPrint("Reason : \(newPath.unsatisfiedReason.description())")
            
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
    
