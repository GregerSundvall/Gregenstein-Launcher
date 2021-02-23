//
//  Tile.swift
//  Engine
//
//  Created by Greger Sundvall on 2021-01-13.
//


public enum Tile: Int, Decodable {
    case floor
    case wall
    case wallGreenish
    case wallArt
    case floorLava
}

public extension Tile {
    var isWall: Bool {
        switch self {
        case .wall, .wallGreenish, .wallArt:
            return true
        case .floor, .floorLava:
            return false
        }
    }
    
    var textures: [Texture] {
        switch self {
        case .floor:
            return [.floor, .ceiling]
        case .floorLava:
            return [.floorLava, .ceiling]
        case .wall:
            return [.wall, .wall2]
        case .wallGreenish:
            return [.wallGreenish, .wallGreenish2]
        case .wallArt:
            return [.wallArt, .wallArt2]
        }
    }
}
