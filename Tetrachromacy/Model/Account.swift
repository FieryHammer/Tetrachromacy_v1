//
//  Account.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 15..
//  Copyright © 2018. Finastra. All rights reserved.
//

import Foundation

enum AccountType: Int {
    case saving = 0, checking
}

enum AccountStatus: String {
    case active = "Active"
    case disabled = "Disabled"
}

struct Account {
    let type: AccountType
    let status: AccountStatus
    let name: String
    let currency: String
    
    init(type: AccountType, status: AccountStatus, name: String, currency: String) {
        self.type = type
        self.status = status
        self.name = name
        self.currency = currency
    }
}
