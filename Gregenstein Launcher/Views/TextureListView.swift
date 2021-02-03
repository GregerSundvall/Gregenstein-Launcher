//
//  Textures.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-22.
//

import SwiftUI

struct TextureListView: View {

    @State var textures = [Texture]()
    
    
    init() {
        textures.append(Texture(image: UIImage(named: "texture0")!))
        print(textures.count)
    }

    var body: some View {
        
        
        List() {
            ForEach(textures) { texture in
                Text("asdf")
                Image(uiImage: texture.image)
                //TextureListItem(texture: texture)
            }
        }
    }
    
    
    
   
}

struct TextureListItem: View {
    let texture: Texture
    var body: some View {
        //NavigationLink(destination: TextureDetailsView(texture: texture)) {
            HStack {
                Image(uiImage: texture.image).interpolation(.none).resizable().frame(width: 100, height: 100).aspectRatio(contentMode: .fill)
                //Text(texture.name)
            }
        //}
    }
}



struct Textures_Previews: PreviewProvider {
    static var previews: some View {
        TextureListView()
    }
}
