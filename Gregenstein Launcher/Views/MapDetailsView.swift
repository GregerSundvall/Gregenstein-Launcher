//
//  MapDetails.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import SwiftUI

struct MapDetailsView: View {

    var map: Map
    @State var name = ""
    @State var mapArray = [Int]()
    var currentTexture = WallTexture(name: "0", image: UIImage())
    
    var body: some View {
        
        
        
        HStack() {
            let gridItemLayout = Array(repeating: GridItem(.fixed(20)), count: 10)
            
            
            LazyVGrid(columns: gridItemLayout, spacing: 5) {
                
                
                ForEach(mapArray.indices, id: \.self) { index in
                    
                    Text(String(mapArray[index]))

                }
            }.navigationTitle(map.name).onAppear() {name = map.name; mapArray = map.mapArray }
        }
        
        Spacer()
        
        HStack {
            
            Image(uiImage: UIImage(named: "texture1")!).resizable().frame(width: 100, height: 100)
        }
        
        Spacer()
        
        HStack {
            Image(uiImage: UIImage(named: "texture1")!).resizable().frame(width: 100, height: 100)
        }
        
        
     
        
    }
    
    func getMapArray() {
        self.mapArray = map.mapArray
    }
    
    
}




struct MapDetails_Previews: PreviewProvider {
    static var previews: some View {
        
        MapDetailsView(map: Maps().list[0])
    }
}
