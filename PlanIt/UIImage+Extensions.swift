//
//  UIImage+Extensions.swift.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/12/22.
//

import Foundation
import UIKit

//UIimage Extension File
extension UIImage {
    func resizeUI(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
