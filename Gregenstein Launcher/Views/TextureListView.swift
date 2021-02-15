//
//  Textures.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-22.
//

import SwiftUI

struct TextureListView: View {
    let map: Map
    let paletteSlot: Int
    @EnvironmentObject var resources: Resources
    //@State var textures = Textures()
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var textureImages = [UIImage]()
    

    var body: some View {
        
        

        List() {
            ForEach(textureImages) { texture in
                HStack {
                    Image(uiImage: texture).interpolation(.none).resizable().frame(width: 60, height: 60).aspectRatio(contentMode: .fill)
                }.onTapGesture {
                    saveTextureToPalette(map: map, slot: paletteSlot, image: texture)
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
        .onAppear() {populateListOfImages()}
    }

    func populateListOfImages() {
        for imageData in resources.textures {
            if let uiImage = UIImage(data: imageData) {
                textureImages.append(uiImage)
            }
        }
    }
    
    func saveTextureToPalette(map: Map, slot: Int, image: UIImage) {
        if let imageData = image.pngData() {
            map.texturePalette[slot] = imageData
        }
        
    }

//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        textures.list.append(inputImage)
//        //image = inputImage
//        //image = Image(uiImage: inputImage)
//    }
}

extension UIImage: Identifiable {}

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
