//
//  UIImageExtension.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-02-16.
//

import Foundation
import SwiftUI

extension UIImage {
    func cropped(to size: CGSize) -> UIImage? {
        guard let cgImage = cgImage?
            .cropping(to: .init(origin: .init(x: (self.size.width - size.width) / 2,
                                              y: (self.size.height - size.height) / 2),
                                size: size)) else { return nil }
        return UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
    }
}
