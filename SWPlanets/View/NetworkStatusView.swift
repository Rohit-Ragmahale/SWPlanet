//
//  NetworkStatusView.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import SwiftUI

struct NetworkStatusView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    var body: some View {
        HStack {
            Spacer()
            networkMonitor.isConnected ?
            Text("Online").padding(5) :
            Text("Offline:" +  networkMonitor.statusMesssage).padding(5)
            Spacer()
        }
        .background(networkMonitor.isConnected ? .green : .gray)
    }
}

struct NetworkStatusView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkStatusView()
    }
}
