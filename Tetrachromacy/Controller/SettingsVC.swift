//
//  SettingsVC.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 11..
//  Copyright © 2018. Finastra. All rights reserved.
//

import UIKit
import DropDown

class SettingsVC: UIViewController {

    @IBOutlet weak var themePickerBtn: UIButton!
    @IBOutlet weak var primaryColorView: UIView!
    @IBOutlet weak var secondaryColorView: UIView!
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ColorService.instance.themes.removeAll()
        
        setupDefaultLook()
        setupDropDown()
    }
    
    func setupDefaultLook() {
        if let currentColor = ColorService.instance.currentColor {
            themePickerBtn.setTitle(currentColor.name, for: .normal)
            primaryColorView.backgroundColor = currentColor.primaryUIColor
            secondaryColorView.backgroundColor = currentColor.secondaryUIColor
        } else {
            primaryColorView.isHidden = true
            secondaryColorView.isHidden = true
        }
    }
    
    func setupDropDown() {
        dropDown.anchorView = themePickerBtn
        dropDown.direction = .top
        dropDown.topOffset = CGPoint(x: 0, y: -themePickerBtn.bounds.height)
        
        ColorService.instance.getThemes { (success) in
            if success {
                self.dropDown.dataSource = ColorService.instance.themes
                
                self.dropDown.selectionAction = { [weak self] (index, item) in
                    self?.themePickerBtn.setTitle(item, for: .normal)
                    
                    ColorService.instance.getColorTheme(for: item, completion: { (success, themeColor) in
                        if success, let newThemeColor = themeColor {
                            self?.themePicked(newThemeColor)
                        }
                    })
                }
            }
        }
    }
    
    func themePicked(_ theme: ThemeColor) {
        CURRENT_COLOR = theme
        UIView.animate(withDuration: 0.3) {
            self.primaryColorView.backgroundColor = CURRENT_COLOR.primaryUIColor
            self.secondaryColorView.backgroundColor = CURRENT_COLOR.secondaryUIColor
            
            if self.primaryColorView.isHidden {
                self.primaryColorView.isHidden = false
                self.secondaryColorView.isHidden = false
            }
            
            NotificationCenter.default.post(name: NOTIFICATION_CURRENT_COLOR_DID_CHANGE, object: nil)
        }
    }
    
    @IBAction func pickThemePressed(_ sender: Any) {
        dropDown.show()
    }
   
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
