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
                    
                    ColorService.instance.getColorTheme(for: item, completion: { (success) in
                        if success {
                            self?.themePicked()
                        }
                    })
                }
            }
        }
        

        
        
    }
    
    func themePicked() {
        UIView.animate(withDuration: 0.3) {
            self.primaryColorView.backgroundColor = ColorService.instance.currentColor.primaryUIColor
            self.secondaryColorView.backgroundColor = ColorService.instance.currentColor.secondaryUIColor
            
            if self.primaryColorView.isHidden {
                self.primaryColorView.isHidden = false
                self.secondaryColorView.isHidden = false
            }
        }
    }
    
    @IBAction func pickThemePressed(_ sender: Any) {
        dropDown.show()
    }
   
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
