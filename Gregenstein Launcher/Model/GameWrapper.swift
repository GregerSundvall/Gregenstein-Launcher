//
//  GameWrapper.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-02-23.
//

import Foundation
import SwiftUI

struct GameWrapper: UIViewControllerRepresentable {
    let map: Map
    func makeUIViewController(context: UIViewControllerRepresentableContext<GameWrapper>) -> ViewController {
        let game = ViewController(map: map)
        return game
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<GameWrapper>) {
    }
    
}
