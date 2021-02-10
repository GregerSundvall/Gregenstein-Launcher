////
////  Textures.swift
////  Gregenstein Launcher
////
////  Created by Greger Sundvall on 2021-01-22.
////
//
//import SwiftUI
//
//struct TextureListView: View {
//
//    @State var textures = Textures()
//    @State private var showingImagePicker = false
//    @State private var inputImage: UIImage?
//    let paletteSlot: Int
//
//    var body: some View {
//
//
//
//        List() {
//            ForEach(textures.list) { texture in
//                Image(uiImage: texture).interpolation(.none).resizable().frame(width: 60, height: 60).aspectRatio(contentMode: .fill)
//            }
//        }.navigationBarItems(trailing: Button(action: {
//            self.showingImagePicker = true
//        }){
//            Image(systemName: "plus")
//        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
//            ImagePicker(image: self.$inputImage)
//        })
//    }
//
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        textures.list.append(inputImage)
//        //image = inputImage
//        //image = Image(uiImage: inputImage)
//    }
//}
//
//extension UIImage: Identifiable {}
//
////struct TextureListItem: View {
////    let texture: Texture
////    var body: some View {
////        //NavigationLink(destination: TextureDetailsView(texture: texture)) {
////            HStack {
////                Image(uiImage: texture.image).interpolation(.none).resizable().frame(width: 100, height: 100).aspectRatio(contentMode: .fill)
////                //Text(texture.name)
////            }
////        //}
////    }
////}
//
//
//
////struct Textures_Previews: PreviewProvider {
////    static var previews: some View {
////        TextureListView()
////    }
////}
