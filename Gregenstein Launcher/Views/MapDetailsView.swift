//
//  MapDetails.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import SwiftUI

struct MapDetailsView: View {
    @EnvironmentObject var resources: Resources
    var map: Map
    var originalMap: Map
    @State var selectedTextureNr = 99
    @State var selectedTextureImg = UIImage()
    @State var mapImgsArray = [UIImage]()
    @State var borders = Array(repeating: CGFloat(0), count: 8)
    @State var uiImagePalette = [UIImage]()
    
    func setupVars() {
        mapImgsArray = map.getImageArray()
        uiImagePalette = map.getUiImageTexturePalette()
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
                            .frame(minWidth: 35, maxWidth: 35, minHeight: 35, maxHeight: 35)
                            .padding(0)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(map.name)
        .navigationBarItems(trailing: Button("Save") {saveMap()} )
        .onAppear() {setupVars()}
        
        Text("Pick a texture below then tap desired area in map to draw.")
            .padding(.top)
            .padding(.bottom, 5)
            .font(.system(size: 12))
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
        
        
        
        Text("Walls").padding(.bottom, -10)
        
        
        HStack {
            ForEach(uiImagePalette.indices, id: \.self) { index in
                
                if index <= 4 {
                    VStack {
                        Button(action: {
                                selectedTextureNr = index
                                selectedTextureImg = uiImagePalette[index]
                                setBorders(box: index)
                        }) {
                            Image(uiImage: uiImagePalette[index]) .resizable().interpolation(.none).frame(width: 50, height: 50)
                        }
                        .padding(5)
                        .border(Color.blue, width: borders[index])
                        
                        
                        
                        NavigationLink(destination: TextureListView(map: map, paletteSlot: index)) {
                            Text("Change...").font(.system(size: 11))
                        }
                        

                    }.padding(3)
                    
                }
            }
        }

        
        Text("Floors").padding(.top).padding(.bottom, -10)
        
        
        HStack {
            ForEach(uiImagePalette.indices, id: \.self) { index in
                
                if index >= 5 {
                    
                    VStack {
                        Button(action: {
                                selectedTextureNr = index
                                selectedTextureImg = uiImagePalette[index]
                                setBorders(box: index)
                        }) {
                            Image(uiImage: uiImagePalette[index]) .resizable().interpolation(.none).frame(width: 50, height: 50)
                        }
                        .padding(5)
                        .border(Color.blue, width: borders[index])
                        Text("Change...").font(.system(size: 11)).padding(-8).foregroundColor(.blue)
                    }.padding(5)
                }
            }
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
        uiImagePalette.removeAll()
        uiImagePalette = map.getUiImageTexturePalette()
//        for texture in map.texturePalette {
//            uiImagePalette.append(map.getUiImage(data: texture.imageData))
//        }
    }
    

   
    func saveMap() {
        if map.id == originalMap.id {
            resources.saveNewMap(map: map)
        } else {
            resources.saveExistingMap(map: map, originalMap: originalMap)
        }
    }
    
    func getDocsDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dataPath = paths[0].appendingPathComponent("maps")
        return dataPath
    }
}

//struct mapArea: View {
//    var map: Map
//    var index: Int
//    
//    var body: some View {
//    
//        Button(action: {
//            drawOneArea(areaNr: index)
//            
//        })    {
//            Image(uiImage: map.getUiImage(data: map.texturePalette[map.mapArray[index]].imageData))
//                .resizable()
//                .interpolation(.none)
//                .frame(minWidth: 35, maxWidth: 35, minHeight: 35, maxHeight: 35)
//                .padding(0)
//        }
//    }
//    
//    func drawOneArea(areaNr: Int) {
//        if selectedTextureNr != 99 {
//            map.mapArray[areaNr] = selectedTextureNr
//            mapImgsArray[areaNr] = selectedTextureImg
//        }
//    }
//}


struct changeTextButton: View {
    var body: some View {
        Text("Change...")
            .font(.system(size: 11))
            .padding(-8)
            .foregroundColor(.blue)
    }
}





//struct MapDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        MapDetailsView()
//    }
//}
