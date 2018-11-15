//
//  SettingsVC.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 11..
//  Copyright © 2018. Finastra. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var cameraImageContainer: RoundedView!
    
    @IBOutlet weak var springImageView: UIImageView!
    @IBOutlet weak var summerImageView: UIImageView!
    @IBOutlet weak var autumnImageView: UIImageView!
    @IBOutlet weak var winterImageView: UIImageView!
    
    private var seasonImageViews = [UIImageView]()
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ColorService.instance.themes.removeAll()
        imagePicker.allowsEditing = false
        
#if targetEnvironment(simulator)
        imagePicker.sourceType = .photoLibrary
#else
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front
        
        let overlay = storyboard?.instantiateViewController(withIdentifier: "CameraOverlay")
        imagePicker.cameraOverlayView = overlay?.view
#endif
        
        imagePicker.delegate = self
        
        seasonImageViews = [springImageView, summerImageView, autumnImageView, winterImageView]
        
        subscribeToColorSwitchingNotification()
        viewsWithPrimaryColor = [view]
        viewsWithTernaryColor = [cameraImageContainer]
        setupGestureRecognizers()
        setupParallax()
    }
    
    func setupGestureRecognizers() {
        let cameraImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cameraContainerTapped))
        cameraImageContainer.addGestureRecognizer(cameraImageTapGestureRecognizer)
        cameraImageContainer.isUserInteractionEnabled = true
        
        seasonImageViews.forEach {
            $0.addGestureRecognizer(getImageTapGestureRecognizer())
            $0.isUserInteractionEnabled = true
        }
    }
    
    func getImageTapGestureRecognizer() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(seasonImagePressedHandler(recognizer:)))
        
    }
    
    @objc func cameraContainerTapped() {
#if targetEnvironment(simulator)
        present(imagePicker, animated: true)
#else
        imagePicker.cameraOverlayView?.isHidden = false
        present(imagePicker, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.imagePicker.cameraOverlayView?.isHidden = true
        }
#endif
        
        
    }
    
    @objc func seasonImagePressedHandler(recognizer: UITapGestureRecognizer) {
        if recognizer.view == springImageView {
            CURRENT_COLOR = SPRING_THEME
        } else if recognizer.view == summerImageView {
            CURRENT_COLOR = SUMMER_THEME
        } else if recognizer.view == autumnImageView {
            CURRENT_COLOR = AUTUMN_THEME
        } else if recognizer.view == winterImageView {
            CURRENT_COLOR = WINTER_THEME
        }
    }
    
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
