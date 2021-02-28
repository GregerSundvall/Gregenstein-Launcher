//
//  Textures.swift
//  Engine
//
//  Created by Greger Sundvall on 2021-01-14.
//

public enum TextureEnum: String, CaseIterable {
    case wall00, wall01
    case wall10, wall11
    case wall20, wall21
    case wall30, wall31
    case wall40, wall41
    case floor0
    case floor1
    case ceiling0
    case ceiling1
    case monsterSun0, monsterSun1, monsterSun2
    //    case monster
//    case monsterWalk1, monsterWalk2
}

public struct Textures {
    public var  textures = [TextureEnum: Bitmap]()
    
    subscript(_ texture: TextureEnum) -> Bitmap {
        return textures[texture]!
    }
}


