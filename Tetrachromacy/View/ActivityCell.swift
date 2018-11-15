//
//  ActivityCell.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 15..
//  Copyright © 2018. Finastra. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {

    @IBOutlet weak var dateMonthLbl: UILabel!
    @IBOutlet weak var dateDayLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(_ activity: Activity) {
        dateMonthLbl.text = activity.dateMonth.rawValue
        dateDayLbl.text = activity.dateDay
        titleLbl.text = activity.title
        subTitleLbl.text = activity.subTitle
        timeLbl.text = activity.time
        priceLbl.text = "$\(activity.price)"
        
        if activity.price > 0 {
            priceLbl.text = "+$\(activity.price)"
            priceLbl.textColor = UIColor.green
        } else {
            priceLbl.text = "-$\(-activity.price)"
            priceLbl.textColor = UIColor.red
        }
    }

}
