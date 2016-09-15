//
//  NSDate.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright (c) 2016 Xmartlabs SRL ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public extension Date {

    /// returns if a date is over 18 years ago
    func isOver18Years() -> Bool {
        var comp = (Calendar.current as NSCalendar).components(NSCalendar.Unit.month.union(.day).union(.year), from: Date())
        guard comp.year != nil && comp.day != nil else { return false }

        comp.year! -= 18
        comp.day! += 1
        if let date = Calendar.current.date(from: comp) {
            if self.compare(date) != ComparisonResult.orderedAscending {
                return false
            }
        }
        return true
    }

    /// returns the month of a date in `MMMM` format
    func monthName() -> String {
        return Constants.Formatters.monthDateFormatter.string(from: self)
    }

    /// returns the year of a date in `yyyy` format
    func year() -> String {
        return Constants.Formatters.yearDateFormatter.string(from: self)
    }

    /// returns the day of a date in `dd` format
    func day() -> String {
        return Constants.Formatters.dayDateFormatter.string(from: self)
    }

}
