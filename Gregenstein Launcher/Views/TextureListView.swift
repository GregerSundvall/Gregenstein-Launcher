//
//  Textures.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-22.
//

import SwiftUI

struct TextureListView: View {

    @ObservedObject var textures = Textures()

    var body: some View {
        
        
            List() {
                ForEach(textures.list) { texture in
                    TextureListItem(texture: texture)
                }
            }
        
        
    }
}

struct TextureListItem: View {
    let texture: WallTexture
    var body: some View {
        NavigationLink(destination:TextureDetailsView(texture: texture)) {
            HStack {
                Image(uiImage: texture.image).interpolation(.none).resizable().frame(width: 100, height: 100).aspectRatio(contentMode: .fill)
                Text(texture.name)
            }
        }
    }
}



struct Textures_Previews: PreviewProvider {
    static var previews: some View {
        TextureListView()
    }
}
