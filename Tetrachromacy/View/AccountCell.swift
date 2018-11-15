//
//  AccountCell.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 15..
//  Copyright © 2018. Finastra. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var accountTypeImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(_ account: Account) {
        if account.type == .checking {
            accountTypeImageView.image = UIImage(named: "CheckingAccountImage")
        } else if account.type == .saving {
            accountTypeImageView.image = UIImage(named: "SavingAccountImage")
        }
        
        nameLbl.text = account.name
        statusLbl.text = account.status.rawValue
        currencyLbl.text = account.currency
    }

}
