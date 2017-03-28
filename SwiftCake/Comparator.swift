//
//  Comparator.swift
//  SwiftCake
//
//  Created by Dominik Majda on 01.03.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import Foundation

public final class Comparator {
    
    public let date: Date
    
    public init(_ date: Date) {
        self.date = date
    }
    
}

extension Comparator {
    
    public func compare(to date: Date, unit: Calendar.Component) -> Int {
        let calendar = Calendar.current
        // TODO
        return -1
    }
}

extension Date {
    
    public var compare: Comparator {
        return Comparator(self)
    }
    
}
