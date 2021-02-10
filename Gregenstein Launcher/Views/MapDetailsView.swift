//
//  MapDetails.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import SwiftUI

struct MapDetailsView: View {
    var map: Map
    @State var selectedTextureNr = 99
    @State var selectedTextureImg = UIImage()
    @State var mapImgsArray = [UIImage]()
    @State var borders = Array(repeating: CGFloat(0), count: 8)
    @State var uiImageTexturePalette = [UIImage]()
    
    func setupVars() {
        mapImgsArray = map.getImageArray()
        uiImageTexturePalette = map.getUiImageTexturePalette()
    }
  
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            let gridItemLayout = Array(repeating: GridItem(.fixed(27)), count: 10)
            
            LazyVGrid(columns: gridItemLayout, spacing: 0) {
                
                ForEach(mapImgsArray.indices, id: \.self) { index in
                    
                    Button(action: {
                        drawOneArea(areaNr: index)
                        
                    })	{
                        Image(uiImage: mapImgsArray[index])
                            .resizable()
                            .interpolation(.none)
                            .frame(minWidth: 35, maxWidth: .infinity, minHeight: 35, maxHeight: .infinity)
                            .padding(0)
                    }
                }
            }
        }
        .navigationBarItems(trailing: Button("Save") {} )
        .onAppear() {setupVars()}
        
        
        Text("Pick a texture below then tap desired area in map to draw. Tap and hold a texture to replace it.").padding().font(.system(size: 12))
        
        
        
        HStack {

            Button(action: {
                    selectedTextureNr = 0
                    selectedTextureImg = uiImageTexturePalette[0]
                    setBorders(box: 0)

            }) {
                Image(uiImage: map.getUiImage(data: map.texturePalette[0])) .resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5)
            .border(Color.blue, width: borders[0])

            Button(action: {
                    selectedTextureNr = 1
                    selectedTextureImg = uiImageTexturePalette[1]
                    setBorders(box: 1)
            }) {
                Image(uiImage: map.getUiImage(data: map.texturePalette[1])).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[1])

            Button(action: {
                    selectedTextureNr = 2
                    selectedTextureImg = uiImageTexturePalette[2]
                    setBorders(box: 2)
            }) {
                Image(uiImage: map.getUiImage(data: map.texturePalette[2])).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[2])

            Button(action: {
                    selectedTextureNr = 3
                    selectedTextureImg = uiImageTexturePalette[3]
                    setBorders(box: 3)
            }) {
                Image(uiImage: map.getUiImage(data: map.texturePalette[3])).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[3])

            Button(action: {
                    selectedTextureNr = 4
                    selectedTextureImg = uiImageTexturePalette[4]
                    setBorders(box: 4)
            }) {
                Image(uiImage: map.getUiImage(data: map.texturePalette[4])).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[4])

        }
        
        
        
        
        HStack {
            Text("Floors").padding(.top)
        }
        
        HStack {

            Button(action: {
                    selectedTextureNr = 5
                    selectedTextureImg = map.getUiImage(data: map.texturePalette[5])
                    setBorders(box: 5)
            }) {
                Image(uiImage: map.getUiImage(data: map.texturePalette[5])).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[5])

            Button(action: {
                    selectedTextureNr = 6
                    selectedTextureImg = map.getUiImage(data: map.texturePalette[6])
                    setBorders(box: 6)
            }) {
                Image(uiImage: map.getUiImage(data: map.texturePalette[6])).resizable().interpolation(.none).frame(width: 50, height: 50)
            }.padding(5).border(Color.blue, width: borders[6])

        
//            Button(action: {
//                    selectedTextureNr = 7
//                    selectedTextureImg = texturePalette[7]
//                    setBorders(box: 7)
//            }) {
//                Image(uiImage: texturePalette[7]).resizable().interpolation(.none).frame(width: 50, height: 50)
//            }.padding(5).border(Color.blue, width: borders[7])
//            .onLongPressGesture {
//                openTextureList()
//            }
            
            
            VStack {
                Image(uiImage: map.getUiImage(data: map.texturePalette[7]))
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 50, height: 50)

                    .border(Color.blue, width: borders[7])
                    .onTapGesture {
                        selectedTextureNr = 7
                        selectedTextureImg = map.getUiImage(data: map.texturePalette[7])
                        setBorders(box: 7)
                    }
//                NavigationLink(destination: TextureListView(paletteSlot: 7)) {
//                    Text("Change...")
//                        .font(.system(size: 12))
//                }


            }.padding(5)


        }
        
        
    }
    
    
    
    
    func setBorders(box: Int) {
        borders = Array(repeating: CGFloat(0), count: 8)
        borders[box] = 2
    }
    
    func drawOneArea(areaNr: Int) {
        if selectedTextureNr != 99 {
            map.mapArray[areaNr] = selectedTextureNr
            mapImgsArray[areaNr] = selectedTextureImg
        }
    }
    
    func populatePaletteImgs() {
        for imagedata in map.texturePalette {
            uiImageTexturePalette.append(map.getUiImage(data: imagedata))
        }
    }
    

   
    func saveMap(name: String, array: [Int], textures: [UIImage]) {
        let newMap = Map(name: name)
        newMap.mapArray = array
        //newMap.textures = textures
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
