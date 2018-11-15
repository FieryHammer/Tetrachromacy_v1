//
//  Constants.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 11..
//  Copyright © 2018. Finastra. All rights reserved.
//

import Foundation

let ACCOUNTS_TITLE = "Accounts"
let CARDS_TITLE = "Cards"
let ATM_BRANCHES_TITLE = "ATM & Branches"
let SETTINGS_TITLE = "Settings"

let MENU_TITLES = [ACCOUNTS_TITLE, CARDS_TITLE, ATM_BRANCHES_TITLE, SETTINGS_TITLE]

//URLs

let HEROKU_URL = "https://damp-escarpment-79041.herokuapp.com/api/colors"
//let HEROKU_URL = "http://localhost:5000/api/colors" // Local testing

// Headers

let DEFAULT_HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let MULTIPART_HEADER = [
    "Content-Type": "multipart/form-data"
]

// Shortcuts

let DEFAULT_THEME_COLOR = ThemeColor(name: "Default", primaryColor: "[255, 255, 255]", secondaryColor: "[255, 255, 255]")
var CURRENT_COLOR: ThemeColor {
    get {
        return ColorService.instance.currentColor
    }
    set(newThemeColor) {
        ColorService.instance.currentColor = newThemeColor
    }
}

// Notifications
let NOTIFICATION_CURRENT_COLOR_DID_CHANGE = Notification.Name("notificationCurrentColorDidChange")

// Account

let account1 = Account(type: .checking, status: .active, name: "1234567****-FIN", currency: "USD")
let account2 = Account(type: .saving, status: .active, name: "4729935****-ASTRA", currency: "USD")
let account3 = Account(type: .saving, status: .disabled, name: "9753675****-MI", currency: "EUR")
let account4 = Account(type: .saving, status: .disabled, name: "1128945****-SYS", currency: "EUR")
let account5 = Account(type: .saving, status: .disabled, name: "9763732****-IND", currency: "HUF")

let accounts = [account1, account2, account3, account4, account5]

// Activities

let activity1 = Activity(dateMonth: .NOV, dateDay: "15", title: "Steam Store", subTitle: "Bought The Elder Scrolls V: Skyrim", price: -59.99, time: "17:48PM")
let activity2 = Activity(dateMonth: .NOV, dateDay: "14", title: "Udemy", subTitle: "FFDC - From zero to hero! course purchase", price: -14.99, time: "23:45PM")
let activity3 = Activity(dateMonth: .NOV, dateDay: "12", title: "Udemy", subTitle: "Learn to code Swift in a day course purchase", price: -9.99, time: "08:01AM")
let activity4 = Activity(dateMonth: .NOV, dateDay: "11", title: "Udemy", subTitle: "How to make good presentation course purchase", price: -14.99, time: "09:32AM")
let activity5 = Activity(dateMonth: .OCT, dateDay: "28", title: "Paypal Transfer", subTitle: "Recieved from Roger Smith", price: 149.53, time: "13:18PM")
let activity6 = Activity(dateMonth: .SEP, dateDay: "07", title: "Pornhub", subTitle: "Subscription", price: -14.99, time: "16:01PM")

let activities = [activity1, activity2, activity3, activity4, activity5, activity6]
