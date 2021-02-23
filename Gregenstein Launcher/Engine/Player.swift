//
//  Player.swift
//  Engine
//
//  Created by Greger Sundvall on 2021-01-13.
//



public struct Player: Actor {
    public let speed: Double = 1.5
    public let turningSpeed: Double = .pi / 2
    public let radius: Double = 0.25
    public var position: Vector
    public var velocity: Vector
    public var direction: Vector
    
    public init(position: Vector) {
        self.position = position
        self.velocity = Vector(x: 0, y: 0)
        self.direction = Vector(x: 1, y: 0)
    }
}

