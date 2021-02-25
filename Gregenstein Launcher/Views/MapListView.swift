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
    
        
        
        
        
        VStack {
            List() {
                ForEach(resources.maps) { map in
                    MapListItem(map: map)
                    
                }
                
            }
        }.onAppear() {resources.loadMaps(); resources.loadTextures()}
    }
}

struct MapListItem: View {
    let map: Map
    let newMap = Map(name: "New map")
    @State var selection: String? = nil
    
    var body: some View {
        
        HStack {
            Text(map.name)
            Spacer()
            
            Text("Edit")
                .background(NavigationLink(
                                "",
                    destination: MapDetailsView(map: getMapCopy(map: map), originalMap: map)
                                ))
//            NavigationLink(
//                destination: GameWrapper(map: map),
//                tag: "play",
//                selection: $selection) { EmptyView()
//            }
//            .frame(width: 0, height: 0)
//            .hidden()
//            .disabled(true)
//
//            NavigationLink(
//                destination: MapDetailsView(map: getMapCopy(map: map),originalMap: map),
//                tag: "edit",
//                selection: $selection) { EmptyView()
//            }
//            .frame(width: 0, height: 0)
//            .hidden()
//            .disabled(true)
//
//            Button("Edit") {
//                }
//                self.selection = "edit"
//            }
//
//            Button("Play") {
//                self.selection = "play"
//            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Maps")
        .navigationBarItems(trailing:
            NavigationLink(destination: MapDetailsView(map: newMap, originalMap: newMap)) {
                Image(systemName: "plus")
            })
        
        

    }
    
   
    
    func getMapCopy(map: Map) -> Map {
        let mapCopy = Map(name: map.name)
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
