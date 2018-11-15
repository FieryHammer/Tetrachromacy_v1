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

    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var libraryImageView: UIImageView!
    
    @IBOutlet weak var springImageView: UIImageView!
    @IBOutlet weak var summerImageView: UIImageView!
    @IBOutlet weak var autumnImageView: UIImageView!
    @IBOutlet weak var winterImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ColorService.instance.themes.removeAll()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        setupGestureRecognizers()
        setupParallax()
    }
    
    func setupGestureRecognizers() {
        let cameraImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cameraContainerTapped))
        let libraryImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(libraryContainerTapped))
        
        cameraImageView.addGestureRecognizer(cameraImageTapGestureRecognizer)
        autumnImageView.addGestureRecognizer(libraryImageTapGestureRecognizer)
        
        cameraImageView.isUserInteractionEnabled = true
        autumnImageView.isUserInteractionEnabled = true
    }
    
    @objc func cameraContainerTapped() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    @objc func libraryContainerTapped() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
//    func themePicked(_ theme: ThemeColor) {
//        CURRENT_COLOR = theme
//        UIView.animate(withDuration: 0.3) {
//            self.primaryColorView.backgroundColor = CURRENT_COLOR.primaryUIColor
//            self.secondaryColorView.backgroundColor = CURRENT_COLOR.secondaryUIColor
//
//            if self.primaryColorView.isHidden {
//                self.primaryColorView.isHidden = false
//                self.secondaryColorView.isHidden = false
//            }
//
//            NotificationCenter.default.post(name: NOTIFICATION_CURRENT_COLOR_DID_CHANGE, object: nil)
//        }
//    }
    
    func setupParallax() {
        let min: CGFloat = -30
        let max: CGFloat = 30
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        let motionEffecGroup = UIMotionEffectGroup()
        motionEffecGroup.motionEffects = [xMotion, yMotion]
        
        springImageView.addMotionEffect(motionEffecGroup)
        summerImageView.addMotionEffect(motionEffecGroup)
        autumnImageView.addMotionEffect(motionEffecGroup)
        winterImageView.addMotionEffect(motionEffecGroup)
    }
   
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else { return }
        ColorService.instance.uploadImage(image) { (success, themeColor) in
            if success {
                // Dummy
                print("Response succesfully recieved!")
            }
        }
    }
}
