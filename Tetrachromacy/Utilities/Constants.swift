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
