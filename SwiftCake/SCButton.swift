//
//  SKButton.swift
//  SwiftCake
//
//  Created by Dominik Majda on 23.02.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

@IBDesignable
public class SCButton: UIButton, SCRoundedBorderedView {
    
    @IBInspectable public var reversed: Bool = false {
        didSet {
            if reversed {
                transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            }
        }
    }

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

public class SCCheckbox: SCButton {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSelectTarget()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSelectTarget()
    }
    
    private func addSelectTarget() {
        self.addTarget(self, action: #selector(reverse), for: .touchUpInside)
    }
    
    func reverse() {
        self.isSelected = !self.isSelected
    }
}
