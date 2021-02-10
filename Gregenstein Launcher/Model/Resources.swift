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
    //var firstRun = true
    //var defaultTextures = [Data]()
    
    init() {
        checkIfFirstRun()
        loadTextures()
        loadMaps()
    }
    
    func loadMaps() {
        var counter = 0
        var keepGoin = true
        
        while keepGoin {
            let url = docsDir.appendingPathComponent("map\(counter)")
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let map = try! decoder.decode(Map.self, from: data)
                maps.append(map)
                print(maps.count)
                counter += 1

            } catch {
                print("All maps added")
                keepGoin = false
            }
        }
        
    }
    
    func loadTextures() {
        var counter = 0
        var keepGoin = true
        
        
        while keepGoin {
            let url = docsDir.appendingPathComponent("texture\(counter)")
            do {
                let data = try Data(contentsOf: url)
                textures.append(data)
                print(textures.count)
                counter += 1

            } catch {
                print("All textures added")
                keepGoin = false
            }
        }
    }
    
    func checkIfFirstRun() {
        let url = docsDir.appendingPathComponent("firstRun")
        
        do {
            _ = try String(contentsOf: url)
            //firstRun = false
            print("not first run")
        } catch {
            saveDefaultsToDocs()
            print("first run")
        }
    }
   
    func saveDefaultsToDocs() {
        let str = ""
        let url = docsDir.appendingPathComponent("firstRun")
        
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            
            saveDefaultTextures()
            saveDefaultMap()
            print("firstrun stuff saved")
        } catch {
            print("error saving first run")
        }
    }
    
    func saveDefaultTextures() {
        for index in 0...7 {
            if let imageData = UIImage(named: "texture\(index)")?.pngData() {
                //defaultTextures.append(imageData)
                let filename = docsDir.appendingPathComponent("texture\(index)")
                try? imageData.write(to: filename)
                print("texture\(index) saved to docs dir")
            }
        }
        
    }
    
    func saveDefaultMap() {
        let map = Map(name: "asdf")
        for texture in textures {
            map.texturePalette.append(texture)
        }
        let jsonData = try! JSONEncoder().encode(map)
        let filename = docsDir.appendingPathComponent("map0")
        try? jsonData.write(to: filename)
        print("map written to docs?")
        
        
    }
    
}
