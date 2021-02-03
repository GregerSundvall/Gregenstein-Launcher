//
//  Map.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import Foundation
import SwiftUI

class Map: Identifiable, ObservableObject {
    var id = UUID()
    var name: String
    @Published var mapArray = [Int]()
    var actorsArray = [Int]()
    @Published var textures = [UIImage]()
    
    init(name: String) {
        self.name = name
        
        addDefaultData()
    }
    
    func addDefaultData() {
        mapArray = [
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 7, 7, 7, 7, 7, 7, 7, 7, 0,
            0, 7, 5, 5, 5, 5, 5, 5, 7, 0,
            0, 7, 5, 2, 7, 7, 2, 5, 7, 0,
            0, 7, 5, 7, 6, 6, 7, 5, 7, 0,
            0, 7, 5, 7, 6, 6, 7, 5, 7, 0,
            0, 7, 5, 2, 7, 7, 2, 5, 7, 0,
            0, 7, 5, 5, 5, 5, 5, 5, 7, 0,
            0, 7, 7, 7, 7, 7, 7, 7, 7, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0
            ]
        
        actorsArray = [
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 2, 0, 0, 0, 0, 0, 0, 2, 0,
            0, 0, 0, 0, 0, 2, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 2, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 2, 0, 0, 0, 0, 0,
            0, 2, 0, 0, 0, 0, 0, 0, 1, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0
            ]
        
        for nr in 0...7 {
            if let texture = UIImage(named: "texture\(nr)") {
                textures.append(texture)
            }
        }
        
        
        
    }
    
    
}


