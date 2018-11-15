//
//  MenuCell.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 11..
//  Copyright © 2018. Finastra. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureWith(title: String) {
        titleLbl.text = title
    }

}
