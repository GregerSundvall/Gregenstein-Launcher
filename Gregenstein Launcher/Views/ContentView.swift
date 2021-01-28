//
//  ContentView.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        
        NavigationView {
            VStack {
                
                Image("logo").resizable().scaledToFit().frame(width: 300)
                Spacer()
                NavigationLink(
                    destination: TextureListView(),
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
                    destination: TextureListView(),
                    label: {
                        Text("Textures")
                    }).padding()
                Spacer()
            }
        }
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
