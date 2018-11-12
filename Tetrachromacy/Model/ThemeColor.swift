//
//  Color.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 11..
//  Copyright © 2018. Finastra. All rights reserved.
//

import Foundation

let PRIMARY_COLOR_KEY = "primary_color"
let SECONDARY_COLOR_KEY = "secondary_color"

struct ThemeColor {
    let name: String
    let primaryColor: String!
    let secondaryColor: String!
    var primaryUIColor: UIColor! {
        get {
            return colorFromString(primaryColor)
        }
    }
    var secondaryUIColor: UIColor! {
        get {
            return colorFromString(secondaryColor)
        }
    }
    
    init(name: String, primaryColor: String, secondaryColor: String) {
        self.name = name
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    func colorFromString(_ string: String) -> UIColor {
        let colorArray = string.trimmingCharacters(in: CharacterSet(charactersIn: "[]")).replacingOccurrences(of: " ", with: "").split(separator: ",")

        if colorArray.count == 3 {
            let rString = NSString(string: String(colorArray[0])).doubleValue
            let gString = NSString(string: String(colorArray[1])).doubleValue
            let bString = NSString(string: String(colorArray[2])).doubleValue
            
            let r = CGFloat(rString)
            let g = CGFloat(gString)
            let b = CGFloat(bString)
            
            return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
        }
        
        return UIColor.white
    }
}
