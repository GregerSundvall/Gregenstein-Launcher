//
//  Texture.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-02-01.
//

import Foundation
import SwiftUI

class Texture: Identifiable {
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    
}


class WallTexture {
    var image : UIImage
    var dark: UIImage
    
    init(image: UIImage, dark: UIImage) {
        self.image = image
        self.dark = dark
    }
}





class FloorCeilingTexture {
    var floor: UIImage
    var ceiling: UIImage
    
    init(floor: UIImage, ceiling: UIImage) {
        self.floor = floor
        self.ceiling = ceiling
    }
}

