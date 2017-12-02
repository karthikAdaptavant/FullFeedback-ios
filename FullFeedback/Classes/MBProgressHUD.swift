//
//  MBProgressHUDExtension.swift
//  FullMobile
//
//  Copyright (c) 2015 FullCreative. All rights reserved.
//

import UIKit
import MBProgressHUD

extension MBProgressHUD {

    var tapGestureRecognizer: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(hudTapped))
    }
    
    func setupHUD(delay: TimeInterval = 0) {
        self.removeFromSuperViewOnHide = false
        self.dimBackground = false
        self.detailsLabelFont = self.labelFont
        self.accessibilityLabel = "progressHUD"        
    }
    
    func setDelay(delay: TimeInterval, tapToClose: Bool) {
        
        self.removeGestureRecognizer(tapGestureRecognizer)
        
        // for alerts
        if delay > 0 {
    
            DispatchQueue.main.async {
                self.hide(true, afterDelay: delay)
            }
            
            self.isUserInteractionEnabled = true

            self.addGestureRecognizer(tapGestureRecognizer)
            
        } else { // for Loaders
            
            if tapToClose {
                self.isUserInteractionEnabled = false // for bottom loader
            } else {
                self.isUserInteractionEnabled = true // Normal loader
            }
        }
    }
    
    func showLoader(msg: String, detailMsg: String = "", delay: TimeInterval = 0) {
        
        setupHUD()
        
        setText(msg: msg, detailMsg: detailMsg)
        self.mode = .indeterminate
        self.show(true)
        
        setDelay(delay: delay, tapToClose: false)
    }
    
    func showBottomLoader(delay: TimeInterval = 0) {

        setupHUD()
        setText(msg: "")
        self.mode = .indeterminate
        self.yOffset = self.frame.size.height/2.5
        self.show(true)
        setDelay(delay: delay, tapToClose: true)
    }
    
    func setText(msg: String, detailMsg: String = "") {
        self.labelText = msg
        self.detailsLabelText = detailMsg
    }
    
    func showText(msg: String, detailMsg: String = "", delay: TimeInterval = 0) {
        
        setupHUD()
        self.mode = .text
        
        setText(msg: msg, detailMsg: detailMsg)
        self.show(true)
        
        setDelay(delay: delay, tapToClose: false)
    }
    
    func hideHud() {
        
        if !self.isHidden {
            self.hide(true)
        }
    }
    
    @objc func hudTapped() {
        if !self.isHidden {
            self.hide(true)
        }
    }
}
