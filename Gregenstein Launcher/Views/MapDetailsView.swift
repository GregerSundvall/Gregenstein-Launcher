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
    //@State var mapArray = [Int]()
    @State var chosenTextureNr = 99
    @State var chosenTextureImg = UIImage()
    //@State var picArray = [UIImage]()
    @State var textureNrs = [Int]()
    @State var textureImgs = [UIImage]()
    
    init(map: Map) {
        self.map = map
        self.name = map.name
        
        
        
    }
    
    var body: some View {
        
        
        
        HStack(alignment: .center, spacing: 0) {
            let gridItemLayout = Array(repeating: GridItem(.fixed(27)), count: 10)
            
            
            
            
            LazyVGrid(columns: gridItemLayout, spacing: 0) {
                
                
                ForEach(textureNrs.indices, id: \.self) { index in
                    
                    Button(action: {
                        print("button \(index) pressed")
                        setOneArea(areaNr: index)
                        //textureNrs[index] = chosenTextureNr
                        //textureImgs[index] = chosenTextureImg
                        
                    })	{
                        Image(uiImage: textureImgs[index]).resizable().interpolation(.none).frame(minWidth: 35, maxWidth: .infinity, minHeight: 35, maxHeight: .infinity).padding(0)
                    }
                    
                }
            }
        }.onAppear() { populateMapLists(); chosenTextureImg = getUIImage(name: "texture0") }
        .navigationBarItems(trailing: Button("Save") {} )
        
        Text("Pick a texture below then tap desired area in map to draw. Tap and hold texture to replace it.").padding().font(.system(size: 12))

        
        HStack {
            
            Button(action: {chosenTextureNr = 0; chosenTextureImg =  getUIImage(name: "texture0")}) {
                if let image = map.textures[0] {
                    Image(uiImage: image).resizable().interpolation(.none).frame(width: 80, height: 80)

                }
            }
//            Button(action: {chosenTexture = 1}) {
//                Image(uiImage: map.textures[1]!).resizable().interpolation(.none).frame(width: 80, height: 80)
//            }
//            Button(action: {chosenTexture = 2}) {
//                Image(uiImage: map.textures[2]!).resizable().interpolation(.none).frame(width: 80, height: 80)
//            }
//            Button(action: {chosenTexture = 2}) {
//                Image(uiImage: map.textures[3]!).resizable().interpolation(.none).frame(width: 80, height: 80)
//            }

        }
        
        Spacer()
//
//        HStack {
//            Image(uiImage: map.textures[4]).resizable().interpolation(.none).frame(width: 80, height: 80)
//            Image(uiImage: map.textures[5]).resizable().interpolation(.none).frame(width: 80, height: 80)
//            Image(uiImage: map.textures[6]).resizable().interpolation(.none).frame(width: 80, height: 80)
//            Image(uiImage: map.textures[7]).resizable().interpolation(.none).frame(width: 80, height: 80)
//        }
        
        
     
        
    }
    
    func setOneArea(areaNr: Int) {
        if chosenTextureNr != 99 {
            textureNrs[areaNr] = chosenTextureNr
            textureImgs[areaNr] = chosenTextureImg
        }
        
    }
    
    func populateMapLists() {
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
    
//    func getMapArray() {
//        self.mapArray = map.mapArray
//
//        for nr in map.mapArray {
//            if let image = UIImage(named: "texture\(nr)") {
//            picArray.append(image)
//            }
//        }
//    }
    
    func getImageName (nr: Int) -> String {
        var name = ""
        switch nr {
        case 0:
            name = "texture5"
        case 1:
            name = "texture1"
        case 2:
            name = "texture2"
        case 3:
            name = "texture3"
        case 4:
            name = "texture4"
        case 5:
            name = "texture6"
        case 6:
            name = "texture7"
        case 7:
            name = "texture8"
        default:
            name = "texture1"
        }
        
        return name
    }
    
    func getImageFromNr(nr: Int) -> UIImage {
        var uiImage = UIImage()
        if let image = UIImage(named: "texture\(nr)") {
            uiImage = image
        }
        return uiImage
    }
    
}




//struct MapDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        MapDetailsView(map: Maps().list[0])
//    }
//}
