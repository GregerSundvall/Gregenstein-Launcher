//
//  Input.swift
//  Engine
//
//  Created by Greger Sundvall on 2021-01-13.
//

public struct Input {
    public var speed: Double
    public var rotation: Rotation
    
    public init(speed: Double, rotation: Rotation) {
        self.speed = speed
        self.rotation = rotation
    }
}
