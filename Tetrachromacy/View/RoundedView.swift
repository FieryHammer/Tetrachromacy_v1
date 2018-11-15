//
//  RoundedView.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 15..
//  Copyright © 2018. Finastra. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
}
