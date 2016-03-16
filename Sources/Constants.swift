//
//  Constants.swift
//  XLFoundationSwiftKit
//
//  Created by Miguel Revetria on 8/12/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

public struct Constants {
    
    public struct Formatters {
        
        static let monthDateFormatter: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMMM"
            
            return formatter
        }()
        
        static let yearDateFormatter: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy"
            
            return formatter
        }()
        
        static let dayDateFormatter: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd"
            
            return formatter
        }()
        
        static let currencyFormatter: NSNumberFormatter = {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            return formatter
        }()
        
        static let currencyFormatterWithoutComma: NSNumberFormatter = {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            formatter.maximumFractionDigits = 0
            return formatter
        }()

    }

}