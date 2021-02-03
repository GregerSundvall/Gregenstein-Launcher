//
//  MapList.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import SwiftUI

struct MapListView: View {
    
    @ObservedObject var maps = Maps()
    
    var body: some View {
        
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
        NavigationLink(destination: MapDetailsView(map: map )) {
            Text(map.name)
        }
    }
}



struct MapList_Previews: PreviewProvider {
    static var previews: some View {
        MapListView()
    }
}
