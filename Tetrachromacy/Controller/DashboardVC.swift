//
//  DashboardVC.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 11..
//  Copyright © 2018. Finastra. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet weak var totalBalanceBGView: UIView!
    @IBOutlet weak var accountsTableView: UITableView!
    @IBOutlet weak var activitiesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        activitiesTableView.delegate = self
        activitiesTableView.dataSource = self
        
        setupGestureRecognizers()
        subscribeToColorSwitchingNotification()
        viewsWithPrimaryColor = [view]
        viewsWithTernaryColor = [totalBalanceBGView]
        tableViewsWithSecondaryColor = [accountsTableView, activitiesTableView]
    }
    
    @IBAction func menuPressed(_ sender: Any) {
        revealViewController()?.revealToggle(animated: true)
    }
    
    func setupGestureRecognizers() {
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}

extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == accountsTableView {
            return accounts.count
        } else if tableView == activitiesTableView {
            return activities.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == accountsTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell") as? AccountCell {
                cell.configureWith(accounts[indexPath.row])
                cell.backgroundColor = backgroundColorForCell(in: tableView)
                
                return cell
            }
        } else if tableView == activitiesTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell") as? ActivityCell {
                cell.configureWith(activities[indexPath.row])
                cell.backgroundColor = backgroundColorForCell(in: tableView)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
