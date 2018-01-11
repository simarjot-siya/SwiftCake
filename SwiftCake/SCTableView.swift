//
//  SCTableView.swift
//  SwiftCake
//
//  Created by Dominik Majda on 20.03.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

public class SCStateTableViewSettings {
    
    static var infoLabelFont: UIFont = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
    static var activityIndicatorStyle: UIActivityIndicatorViewStyle = .gray
    
    
}

@IBDesignable
public class SCStateTableView: UITableView {
    
    // Views
    public let infoLabel = SCAttrLabel()
    public let activityIndicator = UIActivityIndicatorView()
    
    // Default messages
    fileprivate var _initialMessage: String?
    @IBInspectable public var initialMessage: String? {
        didSet {
            self._initialMessage = initialMessage
        }
    }
    fileprivate var _noItemsMessage: String?
    @IBInspectable public var noItemsMessage: String? {
        didSet {
            self._noItemsMessage = noItemsMessage
        }
    }
    
    
    // Updating content insets
    fileprivate var heightConstraints = [NSLayoutConstraint]()
    public override var contentInset: UIEdgeInsets {
        didSet {
            super.contentInset = contentInset
            
            // Update constraints
            self.heightConstraints.forEach { (constraint) in
                constraint.constant = -(contentInset.top)
            }
        }
    }
    
    // State
    public enum TableViewState {
        case loading
        case showItems
        case noItems
        case initial
    }
    public var state: TableViewState {
        didSet {
            self.adoptToState(state)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.state = .initial
        super.init(coder: aDecoder)
        self.addComponents()
        self.adoptToState(.loading)
    }
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        self.state = .initial
        super.init(frame: frame, style: style)
        self.addComponents()
        self.adoptToState(.loading)
    }
    
    fileprivate func adoptToState(_ state: TableViewState) {
        switch state {
        case .loading:
            infoLabel.isHidden = true
            activityIndicator.startAnimating()
        case .noItems:
            infoLabel.isHidden = false
            infoLabel.text = self._noItemsMessage
            activityIndicator.stopAnimating()
        case .showItems:
            infoLabel.isHidden = true
            activityIndicator.stopAnimating()
        case .initial:
            infoLabel.isHidden = false
            infoLabel.text = self._initialMessage
            activityIndicator.stopAnimating()
        }
    }
    
    fileprivate func addComponents() {
        
        // Configure activity indicator
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.activityIndicatorViewStyle = SCStateTableViewSettings.activityIndicatorStyle
        
        // Configure info label
        self.infoLabel.isHidden = true
        self.infoLabel.textAlignment = .center
        self.infoLabel.numberOfLines = 0
        self.infoLabel.font = SCStateTableViewSettings.infoLabelFont
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.textColor = UIColor.lightGray
        
        // Add views to table view
        self.addSubview(activityIndicator)
        self.addSubview(infoLabel)
        
        // Construct center constraints
        self.addConstraint(NSLayoutConstraint(item: self.infoLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        let constraintLabel = NSLayoutConstraint(item: self.infoLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.heightConstraints.append(constraintLabel)
        self.addConstraint(constraintLabel)
        self.addConstraint(NSLayoutConstraint(item: self.activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        let constraintActivity = NSLayoutConstraint(item: self.activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.heightConstraints.append(constraintActivity)
        self.addConstraint(constraintActivity)
        
    }
    
}
