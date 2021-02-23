//
//  Ray.swift
//  Engine
//
//  Created by Greger Sundvall on 2021-01-14.
//

public struct Ray {
    public var origin, direction: Vector
    
    public init(origin: Vector, direction: Vector) {
        self.origin = origin
        self.direction = direction
    }
}

public extension Ray {
    var slopeIntercept: (slope: Double, intercept: Double) {
        let slope = direction.y / direction.x
        let intercept = origin.y - slope * origin.x
        return (slope, intercept)
    }
}
