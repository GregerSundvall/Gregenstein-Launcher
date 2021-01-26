//
//  Maps.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import Foundation

class Maps: ObservableObject {
    
    @Published var list = [Map]()
    
    init() {
        addMockData()
    }
    
    
    
    
    
    func addMockData() {
        list.append(Map(name: "Map 1"))
        list.append(Map(name: "Map 2"))
        list.append(Map(name: "Map 3"))
        list.append(Map(name: "Map 4"))
        list.append(Map(name: "Map 5"))
        list.append(Map(name: "Map 6"))

    }
}
