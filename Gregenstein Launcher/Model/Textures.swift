//
//  Textures.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import Foundation
import SwiftUI

class Textures: ObservableObject {
    
    @Published var list = [WallTexture]()
    
    
    init() {
        var nr = 1
        var oneMore = true
        
        while oneMore {
            oneMore = false
            if let image = UIImage(named: "texture\(nr)") {
                list.append(WallTexture(name: "Texture \(nr)", image: image))
                nr += 1
                oneMore = true
            }
        }
        
        
        
        //addMockData()
    }
    
//    func addMockData() {
//        list.append(Texture(name: "texture 1"))
//        list.append(Texture(name: "texture 2"))
//        list.append(Texture(name: "texture 3"))
//        list.append(Texture(name: "texture 4"))
//        list.append(Texture(name: "texture 5"))
//        list.append(Texture(name: "texture 6"))
//
//    }
}
