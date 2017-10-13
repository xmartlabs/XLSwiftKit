//
//  UITable.swift
//  XLFoundationKit
//
//  Created by mcousillas on 12/7/15.
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

public extension UITableView {

    func setFooterWithSpacing(_ view: UIView) {

        guard self.numberOfSections > 0 else {
            self.tableFooterView = view
            return
        }

        guard let cell = self.cellForRow(at: IndexPath(row: self.numberOfRows(inSection: self.numberOfSections - 1) - 1,
            section: self.numberOfSections - 1)) else {
                self.tableFooterView = view
                return
        }

        let cellY = cell.frame.origin.y
        let footerContainerY = cellY + cell.frame.height
        let footerContainerHeight = UIScreen.main.bounds.height - footerContainerY

        if footerContainerHeight > 0 {
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: footerContainerHeight)
            let footerContainerView = UIView(frame: frame)
            footerContainerView.backgroundColor = .clear
            let viewY = footerContainerHeight - view.frame.height
            view.frame.origin.y = viewY
            view.frame.origin.x = 0
            footerContainerView.addSubview(view)
            self.tableFooterView = footerContainerView
        } else {
            self.tableFooterView = view
        }
    }

    func reloadDataAnimated(_ duration: TimeInterval = 0.4, completion: (() -> Void)?) {
        UIView.transition(
            with: self,
            duration: duration,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.reloadData()
            },
            completion: { _ in completion?() })
    }

}
