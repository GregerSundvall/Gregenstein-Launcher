//
//  MapDetails.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import SwiftUI

struct MapDetailsView: View {

    var map: Map
    @State var name: String
    @State var selectedTextureNr = 99
    @State var selectedTextureImg = UIImage()
    @State var mapArrayNrs: [Int]
    @State var mapArrayImgs = [UIImage]()
    @State var borders = Array(repeating: CGFloat(0), count: 8)
    @State var texturePalette: [UIImage]
    
//    init(map: Map) {
//        self.map = map
//        self._name = State(wrappedValue: map.name)
//        self.texturePalette = map.textures
//        print(self.texturePalette.count)
//    }
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            let gridItemLayout = Array(repeating: GridItem(.fixed(27)), count: 10)
            
            LazyVGrid(columns: gridItemLayout, spacing: 0) {
                
                ForEach(mapArrayImgs.indices, id: \.self) { index in
                    
                    Button(action: {
                        drawOneArea(areaNr: index)
                        
                    })	{
                        Image(uiImage: mapArrayImgs[index]).resizable().interpolation(.none).frame(minWidth: 35, maxWidth: .infinity, minHeight: 35, maxHeight: .infinity).padding(0)
                    }
                }
            }
        }.onAppear() {
            populateMapImgArray() }
        .navigationBarItems(trailing: Button("Save") {} )
        
        Text("Pick a texture below then tap desired area in map to draw. Tap and hold a texture to replace it.").padding().font(.system(size: 12))
        
        HStack {
            Text("Walls")
        }
        
        HStack {
            
            Button(action: {
                    selectedTextureNr = 0
                    selectedTextureImg = texturePalette[0]
                    setBorders(box: 0)
            }) {
                Image(uiImage: texturePalette[0]).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[0])
            
            Button(action: {
                    selectedTextureNr = 1
                    selectedTextureImg = texturePalette[1]
                    setBorders(box: 1)
            }) {
                Image(uiImage: texturePalette[1]).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[1])
            
            Button(action: {
                    selectedTextureNr = 2
                    selectedTextureImg = texturePalette[2]
                    setBorders(box: 2)
            }) {
                Image(uiImage: texturePalette[2]).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[2])
            
            Button(action: {
                    selectedTextureNr = 3
                    selectedTextureImg = texturePalette[3]
                    setBorders(box: 3)
            }) {
                Image(uiImage: texturePalette[3]).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[3])
            
            Button(action: {
                    selectedTextureNr = 4
                    selectedTextureImg = texturePalette[4]
                    setBorders(box: 4)
            }) {
                Image(uiImage: texturePalette[4]).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[4])

        }
        
        HStack {
            Text("Floors").padding(.top)
        }
        
        HStack {
            
            Button(action: {
                    selectedTextureNr = 5
                    selectedTextureImg = texturePalette[5]
                    setBorders(box: 5)
            }) {
                Image(uiImage: texturePalette[5]).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[5])
            
            Button(action: {
                    selectedTextureNr = 6
                    selectedTextureImg = texturePalette[6]
                    setBorders(box: 6)
            }) {
                Image(uiImage: texturePalette[6]).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[6])
            
            Button(action: {
                    selectedTextureNr = 7
                    selectedTextureImg = texturePalette[7]
                    setBorders(box: 7)
            }) {
                Image(uiImage: texturePalette[7]).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[7])
        }
        
        
    }
    
    func setBorders(box: Int) {
        borders = Array(repeating: CGFloat(0), count: 8)
        borders[box] = 2
    }
    
    func drawOneArea(areaNr: Int) {
        if selectedTextureNr != 99 {
            mapArrayNrs[areaNr] = selectedTextureNr
            mapArrayImgs[areaNr] = selectedTextureImg
        }
    }
    
    func populateMapImgArray() {
        for value in mapArrayNrs {
            mapArrayImgs.append(texturePalette[value])
        }
    }
    

   
    func saveMap(name: String, array: [Int], textures: [UIImage]) {
        let newMap = Map(name: name)
        newMap.mapArray = array
        newMap.textures = textures
        }
    
    func getDocsDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dataPath = paths[0].appendingPathComponent("maps")
        
        return dataPath
    }
    
    
    
}




//struct MapDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        MapDetailsView()
//    }
//}
