//
//  UIViewController+ColorSwitching.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 12..
//  Copyright © 2018. Finastra. All rights reserved.
//

import Foundation

private var viewsWithPrimaryColorKey: UInt8 = 0
private var viewsWithSecondaryColorKey: UInt8 = 1
private var tableViewsWithPrimaryColorKey: UInt8 = 2
private var tableViewsWithSecondaryColorKey: UInt8 = 3


extension UIViewController {
    // Add views to this array where you want the color to be the primary color
    var viewsWithPrimaryColor: [UIView]? {
        get {
            return objc_getAssociatedObject(self, &viewsWithPrimaryColorKey) as? [UIView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &viewsWithPrimaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // Add views to this array where you want the color to be the secondary color
    var viewsWithSecondaryColor: [UIView]? {
        get {
            return objc_getAssociatedObject(self, &viewsWithSecondaryColorKey) as? [UIView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &viewsWithSecondaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // Add table views to this array where you want the color to be the primary color
    var tableViewsWithPrimaryColor: [UITableView]? {
        get {
            return objc_getAssociatedObject(self, &tableViewsWithPrimaryColorKey) as? [UITableView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewsWithPrimaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // Add table views to this array where you want the color to be the primary color
    var tableViewsWithSecondaryColor: [UITableView]? {
        get {
            return objc_getAssociatedObject(self, &tableViewsWithSecondaryColorKey) as? [UITableView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewsWithSecondaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // Call this method in UIViewControllers where you want to change colors
    func subscribeToColorSwitchingNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeColors), name: NOTIFICATION_CURRENT_COLOR_DID_CHANGE, object: nil)
    }
    
    @objc func changeColors() {
        // Change background color of views
        viewsWithPrimaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.primaryUIColor }
        viewsWithSecondaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.secondaryUIColor }
        tableViewsWithPrimaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.primaryUIColor }
        tableViewsWithSecondaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.secondaryUIColor }
        
        // Change background color of table view cells
        tableViewsWithPrimaryColor?.forEach { $0.reloadData() }
        tableViewsWithSecondaryColor?.forEach { $0.reloadData() }
        
    }
    
    // Use this method in cellForRowAt: method to set the proper background color
    // TODO: Replace this with an automatic approach if possible
    func backgroundColorForCell(in tableView: UITableView) -> UIColor
    {
        if let primaryTableViews = tableViewsWithPrimaryColor {
            if primaryTableViews.contains(tableView) {
                return CURRENT_COLOR.primaryUIColor
            }
        }

        if let secondaryTableViews = tableViewsWithSecondaryColor {
            if secondaryTableViews.contains(tableView) {
                return CURRENT_COLOR.secondaryUIColor
            }
        }
        
        return UIColor.clear
    }

}

//extension UIViewController: UITableViewDelegate {
//    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let primaryTableViews = tableViewsWithPrimaryColor {
//            if primaryTableViews.contains(tableView) {
//                cell.backgroundColor = CURRENT_COLOR.primaryUIColor
//
//                return
//            }
//        }
//
//        if let secondaryTableViews = tableViewsWithSecondaryColor {
//            if secondaryTableViews.contains(tableView) {
//                cell.backgroundColor = CURRENT_COLOR.secondaryUIColor
//
//                return
//            }
//        }
//    }
//}
