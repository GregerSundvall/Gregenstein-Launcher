//
//  Texture.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-02-01.
//

import Foundation
import SwiftUI

class Texture: Identifiable, Codable {
    var imageData: Data
    
    init(imageData: Data) {
        self.imageData = imageData
    }
    
    
}

