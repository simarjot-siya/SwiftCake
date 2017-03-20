//
//  UIColorExtensions.swift
//  SwiftCake
//
//  Created by Dominik Majda on 07.03.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(r: Int, g: Int, b: Int) {
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
