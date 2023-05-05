//
//  PlanetListView.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import SwiftUI

struct PlanetListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Planet.entity(),
                  sortDescriptors: [ NSSortDescriptor(keyPath: \Planet.name, ascending: true)],
                  animation: .default)
    private var planets: FetchedResults<Planet>

    var body: some View {
        VStack {
            HStack {
                Text("Star War Planet List")
                    .font(.headline)
            }
            if planets.isEmpty {
                Text("No data found!\nPlease check your network connection and try again.")
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .font(.title2)
                    
            } else {
                List{
                    ForEach(planets, id: \.self) { planet in
                        VStack(alignment: .leading) {
                            Text("\(planet.name)")
                                .padding(.leading, 10)
                                .font(.title2)
                            Text("\(planet.terrain)")
                                .padding(.leading, 10)
                                .font(.title3)
                        }
                    }
                }.listStyle(PlainListStyle())
            }
        }
        
    }
}

struct PlanetListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListView()
    }
}
