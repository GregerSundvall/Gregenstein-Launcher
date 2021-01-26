//
//  TextureDetail.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import SwiftUI

struct TextureDetails: View {
    
    var texture: Texture
    
    var body: some View {
        
        Image(uiImage: texture.image).interpolation(.none) .resizable().frame(width: 300, height: 300).aspectRatio(contentMode: .fill)
            Spacer()
        
        
    }
}



struct TextureDetail_Previews: PreviewProvider {
    static var previews: some View {
        TextureDetails(texture: Textures().list[0])
    }
}
