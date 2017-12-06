//
//  FeedbackViewController.swift
//  FullFeedback
//
//  Created by Karthik on 11/22/17.
//

import UIKit
import MBProgressHUD
open class FeedbackViewController: UIViewController, UITextViewDelegate, KeyboardListenerDelegate {

    @IBOutlet open weak var leftButton: UIButton!
    @IBOutlet open weak var setFeedbackTitle: UILabel!
    @IBOutlet open weak var rightButton: UIButton!
    @IBOutlet open weak var feedbackText: UITextView!
    @IBOutlet open weak var navbarView: UIView!
    @IBOutlet weak var feedbackTextBottomconstraint: NSLayoutConstraint!
    
    var loopToDoKey: String = ""
    open var params: [String : Any] = [:]
    open var setBackgroundColor: UIColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    open var rightButtonTitlecolor: UIColor = UIColor(red: 0.4, green: 0.4, blue: 1, alpha: 1)
    var alertHud: MBProgressHUD!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        navbarView.backgroundColor = setBackgroundColor
        rightButton.setTitleColor(rightButtonTitlecolor, for: .normal)
        rightButton.setTitleColor(rightButtonTitlecolor, for: .highlighted)
        rightButton.setTitleColor(rightButtonTitlecolor, for: .selected)
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setup() {
        alertHud =  self.getAlertHUD(srcView: self.view)
        feedbackText.delegate = self
        AppKeyboardListener.delegate = self
        feedbackText.becomeFirstResponder()
        
        self.feedbackText.layer.cornerRadius = 6
        self.feedbackText.clipsToBounds = true
    }
    
    // MARK: Keyboard delegates
    func keyboard_WillShow(_ notification: Notification) {
        feedbackTextBottomconstraint.constant = AppKeyboardListener.keyboardHt + 5
    }

    func keyboard_WillHide(_ notification: Notification) {
        feedbackTextBottomconstraint.constant = 0
    }
    
    func keyboard_DidShow(_ notification: Notification) {
        print("Keyboard did show is called")
    }
    
    func keyboard_DidHide(_ notification: Notification) {
        print("Keyboard did hide is called")
    }
    
    @IBAction func cancelFeedbackvc(_ sender: UIButton) {
        feedbackText.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendFeedbackButton(_ sender: UIButton) {
        
        guard let text = feedbackText.text, !text.isEmpty else {
            return
        }
        
        self.feedbackText.resignFirstResponder()
        
        self.postFeedback(forText: text)
    }
    
    func postFeedback(forText text: String) {
        
        self.alertHud.showLoader(msg: "Sending....")
        
        let param = FeedbackHelper().getParam(forLoopKey: loopToDoKey, text: text, params: params)
        
        FeedbackHelper().postFeedback(withParam: param ) { (success) in
            
            guard success else {
                self.alertHud.showText(msg: "Something went wrong!", detailMsg: "Please ", delay: 1.9)
                return
            }
            
            self.alertHud.showText(msg: "Feedback sent Successfully ", detailMsg: "", delay: 1.9)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.feedbackText.resignFirstResponder()
                dismissFeedbackvc()
            })
        }
        
        func dismissFeedbackvc() {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
