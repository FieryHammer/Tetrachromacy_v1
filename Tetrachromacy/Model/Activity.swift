//
//  Activity.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 15..
//  Copyright © 2018. Finastra. All rights reserved.
//

import Foundation

enum DateMonth: String {
    case JAN = "JAN"
    case FEB = "FEB"
    case MAR = "MAR"
    case APR = "APR"
    case MAY = "MAY"
    case JUN = "JUN"
    case JUL = "JUL"
    case AUG = "AUG"
    case SEP = "SEP"
    case OCT = "OCT"
    case NOV = "NOV"
    case DEC = "DEC"
}

struct Activity {
    let dateMonth: DateMonth
    let dateDay: String
    let title: String
    let subTitle: String
    let price: Double
    let time: String
    
    init(dateMonth: DateMonth, dateDay: String, title: String, subTitle: String, price: Double, time: String) {
        self.dateMonth = dateMonth
        self.dateDay = dateDay
        self.title = title
        self.subTitle = subTitle
        self.price = price
        self.time = time
    }
}
