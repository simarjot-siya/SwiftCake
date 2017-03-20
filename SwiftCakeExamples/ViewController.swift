//
//  ViewController.swift
//  SwiftCakeExamples
//
//  Created by Dominik Majda on 23.02.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import SwiftCake
import UIKit

enum PrinterOptions: String, CustomStringConvertible {
    case global = "global"
    case time = "time"
    
    var description: String {
        return self.rawValue
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var attrLabel: SCLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageView: SCRoundedBorderedView = SCImageView()
        imageView.borderWidth = 10.0
        
        
        PrinterSettings.shared.register(key: PrinterOptions.time, format: "hh ( . ) mm")
        PrinterSettings.shared.register(key: PrinterOptions.global, format: "dd :) MM :) yyyy")
        
        
        print(attrLabel.attributedText)
        attrLabel.text = "ASD\nASD\nASD"
        print(attrLabel.attributedText)
        
        let now = Date()
        print (now.printer.string(PrinterOptions.time))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

