//
//  FeedbackViewController.swift
//  FullFeedback
//
//  Created by Karthik on 11/22/17.
//

import UIKit
import MBProgressHUD
open class FeedbackViewController: UIViewController, UITextViewDelegate {
    
    var loopToDoKey: String = ""
    open var params: [String : Any] = [:]
    open var setBackgroundColor:UIColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.96)
    var alertHud: MBProgressHUD!
    
    @IBOutlet open weak var leftButton: UIButton!
    @IBOutlet open weak var setFeedbackTitle: UILabel!
    @IBOutlet open weak var rightButton: UIButton!
    @IBOutlet open weak var feedbackText: UITextView!
    @IBOutlet open weak var navbarView: UIView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        alertHud =  self.getAlertHUD(srcView: self.view)
        feedbackText.delegate = self
        feedbackText.becomeFirstResponder()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        navbarView.backgroundColor = setBackgroundColor
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func cancelFeedbackvc(_ sender: UIButton) {
        feedbackText.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendFeedbackButton(_ sender: UIButton) {
        
        guard let text = feedbackText.text, text != "" else {
            return
        }
        
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
