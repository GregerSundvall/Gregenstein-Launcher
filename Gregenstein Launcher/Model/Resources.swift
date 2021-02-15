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
    @Published var textures = [Data]()
    @Published var docsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let fileManager = FileManager()
    var mapsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var map0Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var map0Url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var texturesDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let decoder = JSONDecoder()
    
    init() {
        checkIfFirstRun()
        loadTextures()
        loadMaps()
    }
    
    func saveNewTexture(image: UIImage) {
        let index = textures.endIndex
        let filename = texturesDir.appendingPathComponent("texture\(index)")
        do {
            try image.pngData()?.write(to: filename)
            print("Texture\(index) saved")
        } catch {
            print("Could not save texture: \(error)")
        }
        loadTextures()
        
//        if let imageData = image.pngData() {
//            do {
//                try imageData.write(to: filename)
//                print("Texture\(index) saved")
//            } catch {
//                print("Could not save texture: \(error)")
//            }
//            loadTextures()
//        }
    }
    
    func saveNewMap(map: Map) {
        let mapIndex = maps.endIndex
        let jsonData = try! JSONEncoder().encode(map)
        let mapDir = mapsDir.appendingPathComponent("map\(mapIndex)")
        try? fileManager.createDirectory(at: mapDir, withIntermediateDirectories: true, attributes: nil)
        let filename = mapDir.appendingPathComponent("map\(mapIndex).json")
        try? jsonData.write(to: filename)
        for index in map.texturePalette.indices {
            let textureFilename = mapDir.appendingPathComponent("texture\(index)")
            try? map.texturePalette[index].write(to: textureFilename)
        }
        maps.removeAll()
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
            maps.removeAll()
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
        while keepGoin {
            let mapDir = mapsDir.appendingPathComponent("map\(counter)")
            let mapFile = mapDir.appendingPathComponent("map\(counter).json")
            do {
                let mapData = try Data(contentsOf: mapFile)
                let map = try! decoder.decode(Map.self, from: mapData)
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
            let textureFile = texturesDir.appendingPathComponent("texture\(counter)")
            do {
                let textureData = try Data(contentsOf: textureFile)
                textures.append(textureData)
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
        for index in 0...7 {
            if let imageFromAssets = UIImage(named: "texture\(index)")?.pngData() {
                let filename = texturesDir.appendingPathComponent("texture\(index)")
                do {
                    try imageFromAssets.write(to: filename)
                    //print("Texture\(index) saved")
                } catch {
                    print("Could not save texture: \(error)")
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
        for index in 0...7 {
            if let imageFromAssets = UIImage(named: "texture\(index)")?.pngData() {
                let filename = map0Dir.appendingPathComponent("texture\(index)")
                do {
                    try imageFromAssets.write(to: filename)
                    //print("Default map texture\(index) saved")
                } catch {
                    print("Could not save map texture: \(error)")
                }
            }
        }
        print("Default map textures saved to documents")
    }
    
    
}
