//
//  NSDate.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

public extension NSDate {

    func ISO8601String() -> String {
        return Constants.Formatters.iso8601Formatter.stringFromDate(self)
    }

    func ISO8601DateString() -> String {
        return Constants.Formatters.iso8601DateFormatter.stringFromDate(self)
    }
    
    func isOver18Years() -> Bool {
        let comp = NSCalendar.currentCalendar().components(NSCalendarUnit.Month.union(.Day).union(.Year), fromDate: NSDate())
        comp.year -= 18
        comp.day += 1
        if let date = NSCalendar.currentCalendar().dateFromComponents(comp) {
            if self.compare(date) != NSComparisonResult.OrderedAscending {
                return false
            }
        }
        
        return true
    }

    func monthName() -> String {
        return Constants.Formatters.monthDateFormatter.stringFromDate(self)
    }
    
    func year() -> String {
        return Constants.Formatters.yearDateFormatter.stringFromDate(self)
    }
    
    func day() -> String {
        return Constants.Formatters.dayDateFormatter.stringFromDate(self)
    }

}
