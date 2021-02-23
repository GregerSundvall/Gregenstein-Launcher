//
//  Monster.swift
//  Engine
//
//  Created by Greger Sundvall on 2021-01-15.
//

public enum MonsterState {
    case idle
    case chasing
}


public struct Monster: Actor {
    public let speed: Double = 0.2
    public let radius: Double = 0.4
    public var position: Vector
    public var velocity: Vector = Vector(x: 0, y: 0)
    public var state: MonsterState = .idle
    public var animation: Animation = .monsterIdle
    
    public init(position: Vector) {
        self.position = position
    }
}

public extension Monster {
    mutating func update(in world: World) {
        switch state {
        case .idle:
            if canSeePlayer(in: world) {
                state = .chasing
                animation = .monsterWalk
            }
            velocity = Vector(x: 0, y: 0)
        case .chasing:
            guard canSeePlayer(in: world) else {
                state = .idle
                animation = .monsterIdle
                break
            }
            let direction = world.player.position - position
            velocity = direction * (speed / direction.length)
        }
    }
    
    func canSeePlayer(in world: World) -> Bool {
        let direction = world.player.position - position
        let playerDistance = direction.length
        let ray = Ray(origin: position, direction: direction / playerDistance)
        let wallHit = world.map.hitTest(ray)
        let wallDistance = (wallHit - position).length
        return wallDistance > playerDistance
    }
}

public extension Animation {
    static let monsterIdle = Animation(frames: [.monster], duration: 0)
    static let monsterWalk = Animation(frames: [
        .monsterWalk1,
        .monster,
        .monsterWalk2,
        .monster
    ], duration: 1)
}
