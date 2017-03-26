//
//  SCTextView.swift
//  SwiftCake
//
//  Created by Dominik Majda on 07.03.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

@IBDesignable
open class SCTextView: UITextView, SCRoundedBorderedView {
   
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

@IBDesignable
open class SCTextViewWithPlaceholder: SCTextView {
    
    // Maximum length of text. 0 means no limit.
    @IBInspectable open var maxCharactersCount: Int = 0
    
    // Placeholder properties
    // Need to set both placeHolder and placeholderColor in order to show placeholder in the textview
    @IBInspectable open var placeholder: NSString? {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable open var placeholderColor: UIColor = UIColor(r: 199, g: 199, b: 205) {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable open var placeholderLeftMargin: CGFloat = 5 {
        didSet { setNeedsDisplay() }
    }
    
    // Trim white space and newline characters when end editing. Default is true
    @IBInspectable open var trimWhiteSpaceWhenEndEditing: Bool = true
    
    override open var text: String! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            setNeedsDisplay()
        }
    }
        
    @IBInspectable open var lineFragmentPadding: CGFloat = 5.0 {
        didSet {
            textContainer.lineFragmentPadding = lineFragmentPadding
            setNeedsDisplay()
        }
    }
    
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            textContainer.lineFragmentPadding = lineFragmentPadding
            setNeedsDisplay()
        }
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    // Show placeholder
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        if text.isEmpty {
            guard let placeHolder = placeholder else { return }
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            
            let rect = CGRect(x: textContainerInset.left + placeholderLeftMargin,
                              y: textContainerInset.top,
                              width:   frame.size.width - textContainerInset.left - textContainerInset.right,
                              height: frame.size.height)
            
            var attributes: [String: Any] = [
                NSForegroundColorAttributeName: placeholderColor,
                NSParagraphStyleAttributeName: paragraphStyle,
            ]
            if let font = font {
                attributes[NSFontAttributeName] = font
            }
            
            placeHolder.draw(in: rect, withAttributes: attributes)
        }
    }
    
    // Listen to UITextView notification to handle trimming, placeholder and maximum length
    fileprivate func commonInit() {
        self.contentMode = .redraw
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: NSNotification.Name.UITextViewTextDidEndEditing, object: self)
    }
    
    
    // Trim white space and new line characters when end editing.
    func textDidEndEditing(notification: Notification) {
        if let notificationObject = notification.object as? SCTextViewWithPlaceholder {
            if notificationObject === self {
                if trimWhiteSpaceWhenEndEditing {
                    text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    setNeedsDisplay()
                }
            }
        }
    }
    
    // Limit the length of text
    func textDidChange(notification: Notification) {
        if let notificationObject = notification.object as? SCTextViewWithPlaceholder {
            if notificationObject === self {
                if maxCharactersCount > 0 && text.characters.count > maxCharactersCount {
                    
                    let endIndex = text.index(text.startIndex, offsetBy: maxCharactersCount)
                    text = text.substring(to: endIndex)
                    undoManager?.removeAllActions()
                }
                setNeedsDisplay()
            }
        }
    }
    
    // Remove notification observer when deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

@IBDesignable
open class SCGrowingTextView: SCTextViewWithPlaceholder {
    
    // Maximm height of the textview
    @IBInspectable open var maxHeight: CGFloat = CGFloat(0)
    fileprivate weak var heightConstraint: NSLayoutConstraint?
    
    // Initialize
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 30)
    }
    
    func associateConstraints() {
        // iterate through all text view's constraints and identify
        // height,from: https://github.com/legranddamien/MBAutoGrowingTextView
        for constraint in self.constraints {
            if (constraint.firstAttribute == .height) {
                if (constraint.relation == .equal) {
                    self.heightConstraint = constraint;
                }
            }
        }
    }
    
    // Listen to UITextView notification to handle trimming, placeholder and maximum length
    fileprivate override func commonInit() {
        super.commonInit()
        associateConstraints()
    }
    
    // Calculate height of textview
    override open func layoutSubviews() {
        super.layoutSubviews()
        let size = sizeThatFits(CGSize(width:bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
        var height = size.height
        if maxHeight > 0 {
            height = min(size.height, maxHeight)
        }
        
        if (heightConstraint == nil) {
            heightConstraint = NSLayoutConstraint(item: self,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: height)
            addConstraint(heightConstraint!)
        }
        
        if height != heightConstraint?.constant {
            self.heightConstraint!.constant = height;
            scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    
    
}
