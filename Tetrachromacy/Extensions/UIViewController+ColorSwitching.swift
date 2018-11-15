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
private var viewsWithTernaryColorKey: UInt8 = 2
private var tableViewsWithPrimaryColorKey: UInt8 = 3
private var tableViewsWithSecondaryColorKey: UInt8 = 4
private var tableViewsWithTernaryColorKey: UInt8 = 5


extension UIViewController {
    // Add views to this array where you want the color to be the primary color
    var viewsWithPrimaryColor: [UIView]? {
        get {
            return objc_getAssociatedObject(self, &viewsWithPrimaryColorKey) as? [UIView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &viewsWithPrimaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            viewsWithPrimaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.primaryUIColor }
        }
    }
    
    // Add views to this array where you want the color to be the secondary color
    var viewsWithSecondaryColor: [UIView]? {
        get {
            return objc_getAssociatedObject(self, &viewsWithSecondaryColorKey) as? [UIView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &viewsWithSecondaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            viewsWithSecondaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.secondaryUIColor }
        }
    }
    
    // Add views to this array where you want the color to be the ternary color
    var viewsWithTernaryColor: [UIView]? {
        get {
            return objc_getAssociatedObject(self, &viewsWithTernaryColorKey) as? [UIView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &viewsWithTernaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            viewsWithTernaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.ternaryUIColor }
        }
    }
    
    // Add table views to this array where you want the color to be the primary color
    var tableViewsWithPrimaryColor: [UITableView]? {
        get {
            return objc_getAssociatedObject(self, &tableViewsWithPrimaryColorKey) as? [UITableView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewsWithPrimaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            tableViewsWithPrimaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.primaryUIColor }
        }
    }
    
    // Add table views to this array where you want the color to be the primary color
    var tableViewsWithSecondaryColor: [UITableView]? {
        get {
            return objc_getAssociatedObject(self, &tableViewsWithSecondaryColorKey) as? [UITableView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewsWithSecondaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            tableViewsWithSecondaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.secondaryUIColor }
        }
    }
    
    // Add table views to this array where you want the color to be the primary color
    var tableViewsWithTernaryColor: [UITableView]? {
        get {
            return objc_getAssociatedObject(self, &tableViewsWithTernaryColorKey) as? [UITableView]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewsWithTernaryColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            tableViewsWithTernaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.ternaryUIColor }
        }
    }
    
    // Call this method in UIViewControllers where you want to change colors
    func subscribeToColorSwitchingNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewColors), name: NOTIFICATION_CURRENT_COLOR_DID_CHANGE, object: nil)
    }
    
    @objc func changeViewColors() {
        // Change background color of views
        viewsWithPrimaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.primaryUIColor }
        viewsWithSecondaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.secondaryUIColor }
        viewsWithTernaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.ternaryUIColor}
        tableViewsWithPrimaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.primaryUIColor }
        tableViewsWithSecondaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.secondaryUIColor }
        tableViewsWithTernaryColor?.forEach { $0.backgroundColor = CURRENT_COLOR.ternaryUIColor }
        
        // Change background color of table view cells
        tableViewsWithPrimaryColor?.forEach { $0.reloadData() }
        tableViewsWithSecondaryColor?.forEach { $0.reloadData() }
        tableViewsWithTernaryColor?.forEach { $0.reloadData() }
        
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
        
        if let ternaryTableViews = tableViewsWithTernaryColor {
            if ternaryTableViews.contains(tableView) {
                return CURRENT_COLOR.ternaryUIColor
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
