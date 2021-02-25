//
//  Thing.swift
//  Engine
//
//  Created by Greger Sundvall on 2021-01-13.
//


public enum Thing: Int, Decodable, CaseIterable {
    case nothing
    case player
    case monster
}
