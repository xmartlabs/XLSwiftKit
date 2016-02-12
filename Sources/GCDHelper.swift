//
//  GDC.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 25/11/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

/** Helpers to easily use Grand Central Dispatch functions */
public struct GCDHelper {

    public static let mainQueue: dispatch_queue_t = {
       return dispatch_get_main_queue()
    }()
    
    public static let backgroundQueue: dispatch_queue_t = {
        return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
    }()
    
    public static func delay(delay: Double, block: () -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            GCDHelper.mainQueue, block)
    }
    
    public static func runOnMainThread(block: () -> ()) {
        dispatch_async(GCDHelper.mainQueue, block)
    }
    
    public static func runOnBackgroundThread(block: () -> ()) {
        dispatch_async(GCDHelper.backgroundQueue, block)
    }
}
