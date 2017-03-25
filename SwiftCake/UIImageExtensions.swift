//
//  UIImageExtensions.swift
//  SwiftCake
//
//  Created by Dominik Majda on 26.03.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Returns this image with width scaled to given value
    ///
    /// - parameter newWidth: maximum width of photo
    ///
    /// - returns: the same image, but resized to given width
    public func resizeImage(newWidth width: CGFloat = 900 ) -> UIImage? {
        
        let scale = width / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: width, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: width, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    public func resizeToJPEGRepresentation(newWidth width: CGFloat = 900) -> Data? {
        
        // Resize and decode image to be data
        guard let resizedImage = self.resizeImage(newWidth: width),
            let dataImage = UIImageJPEGRepresentation(resizedImage, 0.9) else {
                return nil
        }
        return dataImage
    }
}
