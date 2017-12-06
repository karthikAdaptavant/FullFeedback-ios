//
//  KeyboardListener.swift
//  AWW
//
//  Created by Karthik on 5/31/17.
//  Copyright © 2017 AnywhereWorks. All rights reserved.
//

import Foundation
import UIKit


let AppKeyboardListener: KeyboardListener = KeyboardListener.instance()

protocol KeyboardListenerDelegate: class {
    func keyboard_WillShow(_ notification: Notification)
    func keyboard_DidShow(_ notification: Notification)
    func keyboard_WillHide(_ notification: Notification)
    func keyboard_DidHide(_ notification: Notification)
}

class KeyboardListener: NSObject {
    
    var keyboardHt: CGFloat = 256
    
    var isKeyboardVisible: Bool = false
    
    weak var delegate: KeyboardListenerDelegate?
    
    class func instance() -> KeyboardListener {
        
        let listener = KeyboardListener()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(listener, selector: #selector(keyboard_WillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(listener, selector: #selector(keyboard_WillHide(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(listener, selector: #selector(keyboard_DidHide(_:)), name: Notification.Name.UIKeyboardDidHide, object: nil)
        notificationCenter.addObserver(listener, selector: #selector(keyboard_DidShow(_:)), name: Notification.Name.UIKeyboardDidShow, object: nil)
        
        return listener
    }
    
    
    // Show Methods
    func keyboard_WillShow(_ notification: Notification) {
        
        let userInfo = notification.userInfo!
        let kbSize: CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        keyboardHt = kbSize.height
        
        isKeyboardVisible = true
        
        delegate?.keyboard_WillShow(notification)
    }
    
    func keyboard_DidShow(_ notification: Notification) {
        delegate?.keyboard_DidShow(notification)
    }
    
    // Hide Methods
    func keyboard_WillHide(_ notification: Notification) {
        isKeyboardVisible = false
        delegate?.keyboard_WillHide(notification)
    }
    
    func keyboard_DidHide(_ notification: Notification) {
        isKeyboardVisible = false
        delegate?.keyboard_DidHide(notification)
    }
}