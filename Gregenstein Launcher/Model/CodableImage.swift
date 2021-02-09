//
//  CodableImage.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-02-09.
//

import Foundation
import SwiftUI


struct CodableImage: Codable {
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        return image
    }
}
