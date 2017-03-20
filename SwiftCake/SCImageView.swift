//
//  SCImageView.swift
//  SwiftCake
//
//  Created by Dominik Majda on 23.02.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

@IBDesignable
open class SCImageView: UIImageView, SCRoundedBorderedView {
    
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
