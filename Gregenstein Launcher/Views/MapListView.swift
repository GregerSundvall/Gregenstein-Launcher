//
//  MapList.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import SwiftUI

struct MapListView: View {
    
    @ObservedObject var maps = Maps()
    @EnvironmentObject var resources: Resources
    
    var body: some View {
        Text(String(resources.textures.count))
        VStack {
            List() {
                ForEach(maps.list) { map in
                    MapListItem(map: map)
                }
            }
        }
    }
}

struct MapListItem: View {
    let map: Map
    
    var body: some View {
//        NavigationLink(destination: MapDetailsView(map: map, name: map.name, mapArrayNrs: map.mapArray, texturePalette: map.textures)
//        ) {
//            Text(map.name)
//        }
        Text("asdf")
    }
}



struct MapList_Previews: PreviewProvider {
    static var previews: some View {
        MapListView()
    }
}
