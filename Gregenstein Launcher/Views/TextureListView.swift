//
//  Textures.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-22.
//

import SwiftUI

struct TextureListView: View {
    @Environment(\.presentationMode) var presentationMode
    let map: Map
    let paletteSlot: Int
    @EnvironmentObject var resources: Resources
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    //@State var textureImages = [UIImage]()
    

    var body: some View {
        

        List() {
            ForEach(resources.textures) { texture in
                HStack {
                    textureListItem(texture: texture)
                }.onTapGesture {
                    saveTextureToPalette(map: map, slot: paletteSlot, texture: texture)
                    presentationMode.wrappedValue.dismiss()
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Textures")
        .navigationBarItems(trailing: Button(action: {
            self.showingImagePicker = true
        }){
            Image(systemName: "plus")
        }
        .onTapGesture {
            showingImagePicker = true
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        })
    }

    
    func saveTextureToPalette(map: Map, slot: Int, texture: Texture) {
        map.texturePalette[slot] = texture
    }
}

extension UIImage: Identifiable {}

struct textureListItem: View {
    let texture: Texture
    
    
    var body: some View {
        HStack {
            Image(uiImage: getUIImage(imageData: texture.imageData))
                .interpolation(.none)
                .resizable()
                .frame(width: 60, height: 60)
                .aspectRatio(contentMode: .fill)
            
            Image(uiImage: getUIImage(imageData: texture.imageData2))
                .interpolation(.none)
                .resizable()
                .frame(width: 60, height: 60)
                .aspectRatio(contentMode: .fill)
        }
        
    }
    func getUIImage (imageData: Data) -> UIImage{
        if let image = UIImage(data: imageData) {
            return image
        }
        
        return UIImage()
    }
    
}

//struct TextureListItem: View {
//    let texture: Texture
//    var body: some View {
//        //NavigationLink(destination: TextureDetailsView(texture: texture)) {
//            HStack {
//                Image(uiImage: texture.image).interpolation(.none).resizable().frame(width: 100, height: 100).aspectRatio(contentMode: .fill)
//                //Text(texture.name)
//            }
//        //}
//    }
//}



//struct Textures_Previews: PreviewProvider {
//    static var previews: some View {
//        TextureListView()
//    }
//}
