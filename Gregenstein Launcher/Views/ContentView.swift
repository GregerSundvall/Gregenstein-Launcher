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
                    destination: TextureList(),
                    label: {
                        Text("Play game")
                    })
                Spacer()
                NavigationLink(
                    destination: MapList(),
                    label: {
                        Text("Maps")
                    }).padding()
                NavigationLink(
                    destination: TextureList(),
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
