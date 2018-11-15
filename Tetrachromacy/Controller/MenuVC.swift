//
//  MenuVC.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 11..
//  Copyright © 2018. Finastra. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var avatarImage: CircleImageView!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
        subscribeToColorSwitchingNotification()
        viewsWithPrimaryColor = [view]
        tableViewsWithSecondaryColor = [tableView]
    }

}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MENU_TITLES.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? MenuCell {
            cell.configureWith(title: MENU_TITLES[indexPath.row])
            cell.backgroundColor = backgroundColorForCell(in: tableView)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = MENU_TITLES[indexPath.row]
        
        if title == SETTINGS_TITLE {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            present(vc, animated: true, completion: nil)
            
        } else if title == ACCOUNTS_TITLE {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountsVC") as! AccountsVC
            present(vc, animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
