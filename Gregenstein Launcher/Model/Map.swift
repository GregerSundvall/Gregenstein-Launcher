//
//  Map.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import Foundation
import SwiftUI

class Map: Identifiable, ObservableObject, Codable{
    var id = UUID()
    var name: String
    var mapArray = [Int]()
    var actorsArray = [Int]()
    var texturePalette = [Texture]()
    
    
    init(name: String) {
        self.name = name
        addDefaultData()
    }
    
//    func getUiImgFromPalette(nr: Int) -> UIImage {
//        var uiImage = UIImage()
//        if let image = UIImage(data: texturePalette[nr]) {
//            uiImage = image
//        }
//        return uiImage
//    }
    
    func getUiImage(data: Data) -> UIImage {
        if let image = UIImage(data: data) {
            return image
        }
        return UIImage()
    }
    
    func getUiImageTexturePalette() -> [UIImage] {
        var palette = [UIImage]()
        for texture in texturePalette {
            palette.append(getUiImage(data: texture.imageData))
        }
        return palette
    }
    
    func getImageArray() -> [UIImage] {
        var array = [UIImage]()
        for nr in mapArray {
            array.append(getUiImage(data: texturePalette[nr].imageData))
        }
        return array
    }
    
    func addDefaultData() {
        mapArray = [
            3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
            2, 0, 0, 3, 0, 0, 0, 0, 0, 3,
            2, 0, 0, 3, 0, 0, 0, 0, 0, 3,
            2, 0, 0, 3, 0, 0, 0, 0, 0, 3,
            1, 0, 0, 3, 0, 4, 0, 0, 0, 3,
            1, 0, 0, 0, 0, 0, 0, 0, 0, 3,
            1, 0, 0, 3, 3, 3, 0, 3, 3, 3,
            1, 0, 0, 3, 0, 0, 0, 0, 0, 3,
            2, 0, 0, 3, 0, 0, 0, 0, 0, 3,
            2, 2, 2, 3, 3, 3, 3, 3, 3, 3,
            ]
        
        actorsArray = [
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            ]
        
//        for index in 0...7 {
//            if let image = UIImage(named: "texture\(index)") {
//                if let data = image.pngData() {
//                    texturePalette.append(Texture(imageData: data))
//                } else {
//                    print("could not get image data")
//                }
//            } else {
//                print("Could not get image asset")
//            }
//            //print("One image data added to map palette")
//        }
        print("Map init run. Why is this run a number of times?")
    }
}


