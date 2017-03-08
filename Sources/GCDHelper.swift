//
//  GDC.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 25/11/15.
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

/** Helpers to easily use Grand Central Dispatch functions */
public struct GCDHelper {

    public static let mainQueue: DispatchQueue = {
       return DispatchQueue.main
    }()

    public static let backgroundQueue: DispatchQueue = {
        return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
    }()

    public static func delay(_ delay: Double, block: @escaping () -> Void) {
        GCDHelper.mainQueue.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: block)
    }

    public static func runOnMainThread(_ block: @escaping () -> Void) {
        GCDHelper.mainQueue.async(execute: block)
    }

    public static func runOnBackgroundThread(_ block: @escaping () -> Void) {
        GCDHelper.backgroundQueue.async(execute: block)
    }

    public static func synced(_ lock: AnyObject, closure: () -> Void) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }

}
