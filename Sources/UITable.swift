//
//  UITable.swift
//  XLFoundationKit
//
//  Created by mcousillas on 12/7/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

public extension UITableView {
    
    func setFooterWithSpacing(view: UIView) {
        
        guard self.numberOfSections > 0 else {
            self.tableFooterView = view
            return
        }
        
        guard let cell = self.cellForRowAtIndexPath(NSIndexPath(forRow: self.numberOfRowsInSection(self.numberOfSections - 1) - 1,
            inSection: self.numberOfSections - 1)) else {
                self.tableFooterView = view
                return
        }
        
        let cellY = cell.frame.origin.y
        let footerContainerY = cellY + cell.frame.height
        let footerContainerHeight = UIScreen.mainScreen().bounds.height - footerContainerY
        
        if footerContainerHeight > 0 {
            let footerContainerView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, footerContainerHeight))
            footerContainerView.backgroundColor = .clearColor()
            let viewY = footerContainerHeight - view.frame.height
            view.frame.origin.y = viewY
            view.frame.origin.x = 0
            footerContainerView.addSubview(view)
            self.tableFooterView = footerContainerView
        } else {
            self.tableFooterView = view
        }
    }
}
