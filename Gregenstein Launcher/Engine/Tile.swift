//
//  Tile.swift
//  Engine
//
//  Created by Greger Sundvall on 2021-01-13.
//


public enum Tile: Int, Decodable, CaseIterable {
    
    case wall0
    case wall1
    case wall2
    case wall3
    case wall4
    case open0
    case open1
    case open2
}

public extension Tile {
    var isWall: Bool {
        switch self {
        case .wall0, .wall1, .wall2, .wall3, .wall4:
            return true
        case .open0, .open1, .open2:
            return false
        }
    }
    
    var textures: [TextureEnum] {
        switch self {
        
        case .wall0:
            return [.wall00, .wall01]
        case .wall1:
            return [.wall10, .wall11]
        case .wall2:
            return [.wall20, .wall21]
        case .wall3:
            return [.wall30, .wall31]
        case .wall4:
            return [.wall40, .wall41]
        case .open0:
            return [.floor0, .ceiling0]
        case .open1:
            return [.floor1, .ceiling0]
        case .open2:
            return [.floor1, .ceiling1]
        }
    }
}
