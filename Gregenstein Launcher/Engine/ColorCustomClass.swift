//
//  Color.swift
//  Gregenstein
//
//  Created by Greger Sundvall on 2021-01-13.
//


public struct ColorCustomClass {
    public var r, g, b, a: UInt8
    
    public init(r: UInt8, g: UInt8, b: UInt8, a: UInt8 = 255) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
}

public extension ColorCustomClass {
    static let clear = ColorCustomClass(r: 0, g: 0, b: 0, a: 0)
    static let black = ColorCustomClass(r: 0, g: 0, b: 0)
    static let white = ColorCustomClass(r: 255, g: 255, b: 255)
    static let gray = ColorCustomClass(r: 192, g: 192, b: 192)
    static let red = ColorCustomClass(r: 255, g: 0, b: 0)
    static let green = ColorCustomClass(r: 0, g: 255, b: 0)
    static let blue = ColorCustomClass(r: 0, g: 0, b: 255)

}
