//
//  ContentView.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-22.
//

import SwiftUI

struct MenuStart: View {
    
    @EnvironmentObject var resources : Resources
    @State private var mapToPlay = Map(name: "asdf")
    
    var body: some View {
        
        NavigationView {
            VStack {
                Image("logo").resizable().scaledToFit().frame(width: 300)
                
                Spacer()
                NavigationLink(
                    destination: GameWrapper(map: Map(name: "asdf")),
                    label: {
                        Text("Play game")
                    })
                Spacer()
                NavigationLink(
                    destination: MapListView(),
                    label: {
                        Text("Maps")
                    }).padding()
                NavigationLink(
                    destination: MapListView(),
                    label: {
                        Text("Textures")
                    }).padding()
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("")
        
    }
    
    func setMapToPlay() {
        mapToPlay = resources.mapToPlay
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuStart()
    }
}
