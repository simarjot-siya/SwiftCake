//
//  SCView.swift
//  SwiftCake
//
//  Created by Dominik Majda on 25.03.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
open class SCView: UIView, SCRoundedBorderedView {
    
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            updateCornerRadius(with: cornerRadius)
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            updateBorderWidth(with: borderWidth)
        }
    }
    
    @IBInspectable public var masksToBounds: Bool = false {
        didSet {
            updateMasksToBounds(with: masksToBounds)
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            updateBorderColor(with: borderColor)
        }
    }
    
    
}
