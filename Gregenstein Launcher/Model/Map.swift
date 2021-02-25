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
    var width = 10
    var mapArray = [Int]()
    var actorsArray = [Int]()
    var texturePalette = [Texture]()
    
    
    init(name: String) {
        self.name = name
        addDefaultData()
    }
    
    func getSessionBitmapTextures() -> [TextureEnum:Bitmap]{
        var sessionTextureBitmaps = [TextureEnum:Bitmap]()
        //let caseStrings = ["wall", "wall2", "wallGreenish", "wallGreenish2", "wallArt", "wallArt2", "floor", "floorLava", "ceiling"]
        sessionTextureBitmaps[TextureEnum.wall] = getBitmap(fromData: texturePalette[0].imageData)
        sessionTextureBitmaps[TextureEnum.wall2] = getBitmap(fromData: texturePalette[0].imageData2)
        sessionTextureBitmaps[TextureEnum.wallGreenish] = getBitmap(fromData: texturePalette[1].imageData)
        sessionTextureBitmaps[TextureEnum.wallGreenish2] = getBitmap(fromData: texturePalette[1].imageData2)
        sessionTextureBitmaps[TextureEnum.wallArt] = getBitmap(fromData: texturePalette[2].imageData)
        sessionTextureBitmaps[TextureEnum.wallArt2] = getBitmap(fromData: texturePalette[2].imageData2)
        sessionTextureBitmaps[TextureEnum.floor] = getBitmap(fromData: texturePalette[4].imageData)
        sessionTextureBitmaps[TextureEnum.floorLava] = getBitmap(fromData: texturePalette[4].imageData)
        sessionTextureBitmaps[TextureEnum.ceiling] = getBitmap(fromData: texturePalette[6].imageData)
        sessionTextureBitmaps[TextureEnum.monster] = Bitmap(image: UIImage(named: "monster")!)
        sessionTextureBitmaps[TextureEnum.monsterWalk1] = Bitmap(image: UIImage(named: "monsterWalk1")!)
        sessionTextureBitmaps[TextureEnum.monsterWalk2] = Bitmap(image: UIImage(named: "monsterWalk2")!)
        
//        for index in 0...8 {
//            sessionTextureBitmaps[caseStrings[index]] = Bitmap(UIImage(data: texturePalette[index].imageData))
//        }
        
        return sessionTextureBitmaps
    }
    func getBitmap(fromData: Data) -> Bitmap {
        var bitmap = Bitmap(width: 1, height: 1, color: .red)
        if let image = UIImage(data: fromData) {
            if let bitmapTemp = Bitmap(image: image) {
                bitmap = bitmapTemp
            }
        }
        return bitmap
    }
    
    func dataToUIImage(data: Data) -> UIImage {
        var uiimage = UIImage()
        if let image = UIImage(data: data) {
            uiimage = image
        }
        return uiimage
    }
    
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


