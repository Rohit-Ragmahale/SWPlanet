//
//  NetworkStatusView.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import SwiftUI

struct NetworkStatusView: View {
    @Binding var nonetworkStatusMessage: String
    @Binding var isOnline: Bool
    var body: some View {
        HStack {
            Spacer()
            isOnline ?
            Text("Online").padding(5) :
            Text("Offline:" +  nonetworkStatusMessage).padding(5)
            Spacer()
        }.background(isOnline ? .green : .gray)
    }
}

struct NetworkStatusView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkStatusView(nonetworkStatusMessage: .constant("offline"), isOnline: .constant(true))
    }
}
