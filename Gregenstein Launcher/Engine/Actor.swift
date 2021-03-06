//
//  Actor.swift
//  Engine
//
//  Created by Greger Sundvall on 2021-01-18.
//


public protocol Actor {
    var radius: Double { get }
    var position: Vector { get set }
}

public extension Actor {
    var rect: Rect {
        let halfSize = Vector(x: radius, y: radius)
        return Rect(min: position - halfSize, max: position + halfSize)
    }
    
    func intersection(with map: Tilemap) -> Vector? {
        let minX = Int(rect.min.x), maxX = Int(rect.max.x)
        let minY = Int(rect.min.y), maxY = Int(rect.max.y)
        var largestIntersection: Vector?
        for y in minY ... maxY {
            for x in minX ... maxX where map[x, y].isWall {
                let wallRect = Rect(
                    min: Vector(x: Double(x), y: Double(y)),
                    max: Vector(x: Double(x + 1), y: Double(y + 1))
                                     )
                if let intersection = rect.intersection(with: wallRect),
                    intersection.length > largestIntersection?.length ?? 0{
                    largestIntersection = intersection
                }
            }
        }
        return largestIntersection
    }
    
    func intersection(with actor: Actor) -> Vector? {
        return rect.intersection(with: actor.rect)
    }
}
