//
//  Resources.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-02-09.
//

import Foundation
import SwiftUI

class Resources: ObservableObject {
    @Published var maps = [Map]()
    @Published var textures = [Texture]()
    @Published var docsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let fileManager = FileManager()
    var mapsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var map0Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var map0Url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var texturesDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let decoder = JSONDecoder()
    //@Published var texturesForGame = [String:UIImage]()
    @Published var mapToPlay =  Map(name: "asdf")
    
    init() {
        checkIfFirstRun()
        loadTextures()
        loadMaps()
    }
    
    
    
    func cropImage(uiImage: UIImage) -> UIImage {
        var image = uiImage
        let width = uiImage.size.width
        let height = uiImage.size.height
        let size = CGSize(width: 512, height: 512)
        
        if uiImage.size.height > uiImage.size.width {
            image = image.cropped(to: CGSize(width: width, height: width))!
            print("image squared")
        } else if uiImage.size.width > uiImage.size.height {
            image = uiImage.cropped(to: CGSize(width: height, height: height))!
            print("image squared")
        }
        
        if image.size.width > 512 {
            let renderer = UIGraphicsImageRenderer(size: size)
            let downSampled = renderer.image { (context) in
                image.draw(in: CGRect(origin: .zero, size: size))
            }
            image = downSampled
            print("image downsampled to 512")
        }
        print(image.size)
        return image
    }
    
    
    func saveNewTexture(uiImage: UIImage) {
        let image = cropImage(uiImage: uiImage)
        
        if let imageData = image.pngData() {
            let index = textures.endIndex
            let texture = Texture(imageData: imageData)
            texture.imageData2 = getDarkVersion(uiImage: image)
            let filename = texturesDir.appendingPathComponent("texture\(index).json")
            let jsonData = try! JSONEncoder().encode(texture)
            do {
                try jsonData.write(to: filename)
                print("Texture\(index) saved to docs")
            } catch {
                print("Could not save texture: \(error)")
            }
            textures.append(texture)
            print("Texture added to list")
            print(image.size)
        }
    }
        
    func getDarkVersion(uiImage: UIImage) -> Data {
        var imageData = Data()
        if let currentFilter = CIFilter(name: "CIColorControls") {
            let beginImage = CIImage(image: uiImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(-0.1, forKey: kCIInputBrightnessKey)
            
            let context = CIContext(options: nil)
            
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    
                    if let data = processedImage.pngData() {
                        imageData = data
                    }
                }
            }
        }
        return imageData
    }
    
    func saveNewMap(map: Map) {
        let mapIndex = maps.endIndex
        let jsonData = try! JSONEncoder().encode(map)
        let mapDir = mapsDir.appendingPathComponent("map\(mapIndex)")
        try? fileManager.createDirectory(at: mapDir, withIntermediateDirectories: true, attributes: nil)
        let filename = mapDir.appendingPathComponent("map\(mapIndex).json")
        try? jsonData.write(to: filename)
        for index in map.texturePalette.indices {
            let jsonData = try! JSONEncoder().encode(map.texturePalette[index])
            let textureFilename = mapDir.appendingPathComponent("texture\(index)")
            try? jsonData.write(to: textureFilename)
        }
        loadMaps()
        print("new map saved and list is reloaded")
    }
    
    func saveExistingMap(map: Map, originalMap: Map) {
        if let index = maps.lazy.firstIndex(where: { $0.id == originalMap.id }) {
            maps[index].name = map.name
            maps[index].mapArray = map.mapArray
            maps[index].actorsArray = map.actorsArray
            maps[index].texturePalette = map.texturePalette
            let mapDir = mapsDir.appendingPathComponent("map\(index)")
            let jsonData = try! JSONEncoder().encode(maps[index])
            let filename = mapDir.appendingPathComponent("map\(index).json")
            try? jsonData.write(to: filename)
            print("map changes saved")
            loadMaps()
        } else {
            saveNewMap(map: map)
            print("could not locate original map. Saved as new map")
            maps.removeAll()
            loadMaps()
        }
    }
    
    func loadMaps() {
        var counter = 0
        var keepGoin = true
        maps.removeAll()
        while keepGoin == true {
            let mapDir = mapsDir.appendingPathComponent("map\(counter)")
            let mapFile = mapDir.appendingPathComponent("map\(counter).json")
            do {
                let mapData = try Data(contentsOf: mapFile)
                let map = try! decoder.decode(Map.self, from: mapData)
                
                for index in 0...8 {
                    let textureFile = mapDir.appendingPathComponent("texture\(index).json")
                    do {
                        let textureData = try Data(contentsOf: textureFile)
                        let texture = try decoder.decode(Texture.self, from: textureData)
                        map.texturePalette.append(texture)
                    }
                }
                maps.append(map)
                counter += 1
                print("One map loaded and added to list")
            } catch {
                print("All maps added")
                keepGoin = false
            }
        }
    }
    
    func loadTextures() {
        var counter = 0
        var keepGoin = true
        textures.removeAll()
        while keepGoin {
            let textureFile = texturesDir.appendingPathComponent("texture\(counter).json")
            do {
                let textureData = try Data(contentsOf: textureFile)
                let texture = try! decoder.decode(Texture.self, from: textureData)
                textures.append(texture)
                //print("One texture loaded and added to list")
                counter += 1
            } catch {
                print("All textures loaded from documents")
                keepGoin = false
            }
        }
    }
    
    func checkIfFirstRun() {
        //let url = docsDir.appendingPathComponent("firstRun")
        mapsDir = docsDir.appendingPathComponent("maps")
        map0Dir = mapsDir.appendingPathComponent("map0")
        map0Url = map0Dir.appendingPathComponent("map0.json")
        texturesDir = docsDir.appendingPathComponent("textures")
        do {
            _ = try String(contentsOf: map0Url)
            print("Not first run")
        } catch {
            print("First run. Installing default resources...")
            do {
            try fileManager.createDirectory(at: map0Dir, withIntermediateDirectories: true, attributes: nil)
                print("Default map directory created")
            try fileManager.createDirectory(at: texturesDir, withIntermediateDirectories: true, attributes: nil)
                print("Main textures dir created")
                saveDefaultTextures()
                saveDefaultMap()
            } catch {
                print("Error creating directories: \(error)")
            }
        }
    }

    func saveDefaultTextures() {
        for index in 0...8 {
            if let imageFromAssets = UIImage(named: "texture\(index)") {
                if let imageData = imageFromAssets.pngData() {
                    let texture = Texture(imageData: imageData)
                    texture.imageData2 = getDarkVersion(uiImage: imageFromAssets)
                    let jsonData = try! JSONEncoder().encode(texture)
                    let filename = texturesDir.appendingPathComponent("texture\(index).json")
                    do {
                        try jsonData.write(to: filename)
                        //print("Texture\(index) saved")
                    } catch {
                        print("Could not save texture: \(error)")
                    }
                }
            }
        }
        print("Default textures saved to documents")
    }
    
    func saveDefaultMap() {
        let map = Map(name: "Skeleton dance")
        let jsonData = try! JSONEncoder().encode(map)
        let filename = map0Dir.appendingPathComponent("map0.json")
        //if !fileManager.fileExists(atPath: mapDir.path){}
        do {
            try jsonData.write(to: filename)
            print("Default map saved")
        } catch {
            print("Could not save default map")
        }
        for index in 0...8 {
            if let imageFromAssets = UIImage(named: "texture\(index)") {
                if let imageData = imageFromAssets.pngData() {
                    let texture = Texture(imageData: imageData)
                    texture.imageData2 = getDarkVersion(uiImage: imageFromAssets)
                    let jsonData = try! JSONEncoder().encode(texture)
                    let filename = map0Dir.appendingPathComponent("texture\(index).json")
                    do {
                        try jsonData.write(to: filename)
                        //print("Default map texture\(index) saved")
                    } catch {
                        print("Could not save map texture: \(error)")
                    }
                }
            }
        }
        print("Default map with textures saved to documents")
    }
    
    
}
