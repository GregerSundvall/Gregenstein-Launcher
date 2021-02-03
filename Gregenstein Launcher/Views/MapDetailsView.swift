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
    @State var selectedTextureNr = 99
    @State var selectedTextureImg = UIImage()
    @State var textureNrs = [Int]()
    @State var textureImgs = [UIImage]()
    @State var borders = Array(repeating: CGFloat(0), count: 8)
    @State var textures = [UIImage]()
    
    init(map: Map) {
        self.map = map
        self._name = State(wrappedValue: map.name)
        self.textures = map.textures
        print(self.textures.count)
    }
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            let gridItemLayout = Array(repeating: GridItem(.fixed(27)), count: 10)
            
            
            LazyVGrid(columns: gridItemLayout, spacing: 0) {
                
                
                ForEach(textureNrs.indices, id: \.self) { index in
                    
                    Button(action: {
                        drawOneArea(areaNr: index)
                        
                    })	{
                        Image(uiImage: textureImgs[index]).resizable().interpolation(.none).frame(minWidth: 35, maxWidth: .infinity, minHeight: 35, maxHeight: .infinity).padding(0)
                    }
                    
                }
            }
        }.onAppear() {
            populateMapLists()
            selectedTextureImg = getUIImage(name: "texture0") }
        .navigationBarItems(trailing: Button("Save") {} )
        
        Text("Pick a texture below then tap desired area in map to draw. Tap and hold a texture to replace it.").padding().font(.system(size: 12))

        
        HStack {
            Text("Walls")
        }
        
        
        HStack {
            
            Button(action: {
                    selectedTextureNr = 0
                    selectedTextureImg = getUIImage(name: "texture0")
                    setBorders(box: 0)
            }) {
                if let image = map.textures[0] {
                    Image(uiImage: image).resizable().interpolation(.none).frame(width: 50, height: 50)
                }
            }.padding(5).border(Color.blue, width: borders[0])
            
            Button(action: {
                    selectedTextureNr = 1
                    selectedTextureImg = getUIImage(name: "texture1")
                    setBorders(box: 1)
            }) {
                if let image = map.textures[1] {
                    Image(uiImage: image).resizable().interpolation(.none).frame(width: 50, height: 50)
                }
            }.padding(5).border(Color.blue, width: borders[1])
            
            Button(action: {
                    selectedTextureNr = 2
                    selectedTextureImg = getUIImage(name: "texture2")
                    setBorders(box: 2)
            }) {
                if let image = map.textures[2] {
                    Image(uiImage: image).resizable().interpolation(.none).frame(width: 50, height: 50)
                }
            }.padding(5).border(Color.blue, width: borders[2])
            
            Button(action: {
                    selectedTextureNr = 3
                    selectedTextureImg = getUIImage(name: "texture3")
                    setBorders(box: 3)
            }) {
                if let image = map.textures[3] {
                    Image(uiImage: image).resizable().interpolation(.none).frame(width: 50, height: 50)
                }
            }.padding(5).border(Color.blue, width: borders[3])
            
            Button(action: {
                    selectedTextureNr = 4
                    selectedTextureImg = getUIImage(name: "texture4")
                    setBorders(box: 4)
            }) {
                if let image = map.textures[4] {
                    Image(uiImage: image).resizable().interpolation(.none).frame(width: 50, height: 50)
                }
            }.padding(5).border(Color.blue, width: borders[4])
            

        }
        
        HStack {
            Text("Floors").padding(.top)
            
        }
        
        HStack {
            
            Button(action: {
                    selectedTextureNr = 5
                    selectedTextureImg = getUIImage(name: "texture5")
                    setBorders(box: 5)
            }) {
                if let image = map.textures[5] {
                    Image(uiImage: image).resizable().interpolation(.none).frame(width: 50, height: 50)
                }
            }.padding(5).border(Color.blue, width: borders[5])
            
            Button(action: {
                    selectedTextureNr = 6
                    selectedTextureImg = getUIImage(name: "texture6")
                    setBorders(box: 6)
            }) {
                if let image = map.textures[6] {
                    Image(uiImage: image).resizable().interpolation(.none).frame(width: 50, height: 50)
                }
            }.padding(5).border(Color.blue, width: borders[6])
            
            Button(action: {
                    selectedTextureNr = 7
                    selectedTextureImg = getUIImage(name: "texture7")
                    setBorders(box: 7)
            }) {
                if let image = map.textures[7] {
                    Image(uiImage: image).resizable().interpolation(.none).frame(width: 50, height: 50)
                }
            }.padding(5).border(Color.blue, width: borders[7])
            

        }

        
        
     
        
    }
    
    func setBorders(box: Int) {
        borders = Array(repeating: CGFloat(0), count: 8)
        borders[box] = 2
    }
    
    func drawOneArea(areaNr: Int) {
        if selectedTextureNr != 99 {
            textureNrs[areaNr] = selectedTextureNr
            textureImgs[areaNr] = selectedTextureImg
        }
        
    }
    
    func populateMapLists() {
        //textures = map.textures
        for value in map.mapArray {
            textureNrs.append(value)
            if let image = UIImage(named: "texture\(value)") {
                textureImgs.append(image)
            }
        }
    }
    
    func getUIImage(name: String) -> UIImage {
        if let image = UIImage(named: name) {
            return image
        } else {
            return UIImage()
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
