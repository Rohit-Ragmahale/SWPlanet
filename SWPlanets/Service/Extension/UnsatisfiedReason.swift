//
//  UnsatisfiedReason.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 19/04/2023.
//

import Network

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
