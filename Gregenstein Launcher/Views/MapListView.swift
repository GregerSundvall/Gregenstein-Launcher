//
//  MapList.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import SwiftUI

struct MapListView: View {
    
    @EnvironmentObject var resources: Resources
    
    var body: some View {
        Text("\(resources.maps.count) maps total")
        Text("\(resources.textures.count) textures total")
        
        VStack {
            List() {
                ForEach(resources.maps) { map in
                    MapListItem(map: map)
                    
                }
            }
        }
    }
}

struct MapListItem: View {
    let map: Map
    
    
    var body: some View {
        NavigationLink(destination: MapDetailsView(map: getMapCopy(map: map))
        ) {
            
            VStack {
                Text("Name: \(map.name)")
                Text("Map size: \(map.mapArray.count)")
                Text("Map images count: \(map.getImageArray().count)")
                Text("\(map.texturePalette.count) images in palette")
                HStack {
                    Image(uiImage: map.getUiImageTexturePalette()[0])
                    Image(uiImage: map.getUiImageTexturePalette()[1])
                    Image(uiImage: map.getUiImageTexturePalette()[2])
                    Image(uiImage: map.getUiImageTexturePalette()[3])
                    Image(uiImage: map.getUiImageTexturePalette()[4])
                    Image(uiImage: map.getUiImageTexturePalette()[5])
                    Image(uiImage: map.getUiImageTexturePalette()[6])
                    Image(uiImage: map.getUiImageTexturePalette()[7])
                    
                }
            }
        }
    }
    
    func getMapCopy(map: Map) -> Map {
        let mapCopy = Map(name: map.name)
        mapCopy.id = map.id
        mapCopy.name = map.name
        mapCopy.mapArray = map.mapArray
        mapCopy.actorsArray = map.actorsArray
        mapCopy.texturePalette = map.texturePalette
        
        return mapCopy
    }
}



struct MapList_Previews: PreviewProvider {
    static var previews: some View {
        MapListView()
    }
}
