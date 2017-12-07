//
//  FeedbackViewController.swift
//  FullFeedback
//
//  Created by Karthik on 11/22/17.
//

import UIKit
import MBProgressHUD

extension Dictionary {
    
    mutating func add(key: Key, value: Value?) {
        if let value = value {
            self[key] = value
        }
    }
}

class FeedbackService {
    
    static func getBundle() -> Bundle {
        
        guard let bundle = Bundle(identifier: "org.cocoapods.FullFeedback") else {
            print("bundle not found")
            fatalError()
        }
        return bundle
    }
}

public struct FeedbackPayload {
    
    public var appLogin: String? = ""
    public var appVersion: String = ""
    public var deviceName: String = ""
    public var deviceModel: String = ""
    public var deviceOsVersion: String = ""
    
    public init() { }
    
    func toDict() -> [String: Any] {
        
        var applicationInfo: [String: Any] = [:]
        applicationInfo.add(key: "login", value: self.appLogin)
        applicationInfo["version"] = self.appVersion
        
        let deviceInfo: [String: Any] = ["DeviceName": self.deviceName,
                                         "DeviceType": self.deviceModel,
                                         "DeviceOsVersion": self.deviceOsVersion]
        
        let dict = ["ApplicationInfo": applicationInfo,
                    "DeviceInfo": deviceInfo]
        
        return dict
    }
}

open class FeedbackViewController: UIViewController, UITextViewDelegate, KeyboardListenerDelegate {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var setFeedbackTitle: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var feedbackText: UITextView!
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var feedbackTextBottomconstraint: NSLayoutConstraint!
    
    var loopToDoKey: String = ""
    
    open var navBarColor: UIColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    open var titleColor: UIColor = UIColor(red: 43, green: 51, blue: 62, alpha: 1)
    open var rightButtonTitlecolor: UIColor = UIColor(red: 0.4, green: 0.4, blue: 1, alpha: 1)
    open var leftButtonImage : UIImage?
    open var leftButtonTitle : String = String()
    open var leftbuttonTitleColor : UIColor =  UIColor(red: 0.4, green: 0.4, blue: 1, alpha: 1)
    open var statusBarStyle: UIStatusBarStyle = .default
    
    open var feedbackPayload: FeedbackPayload = FeedbackPayload()
    var alertHud: MBProgressHUD!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        leftButtonProperties()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setup() {
        
        self.alertHud =  self.getAlertHUD(srcView: self.view)
        self.feedbackText.delegate = self
        AppKeyboardListener.delegate = self
        self.feedbackText.becomeFirstResponder()
        
        self.feedbackText.layer.cornerRadius = 6
        self.feedbackText.clipsToBounds = true
        
        self.titleText.textColor = titleColor
        self.navbarView.backgroundColor = navBarColor
        self.rightButton.setTitleColor(rightButtonTitlecolor, for: .normal)
        self.rightButton.setTitleColor(rightButtonTitlecolor, for: .highlighted)
        self.rightButton.setTitleColor(rightButtonTitlecolor, for: .selected)                
    }
    
    func leftButtonProperties(){
        
        // Setting Custom title
        guard leftButtonTitle.isEmpty else {
            leftButton.setImage(nil, for: .normal)
            leftButton.setTitle(" \(leftButtonTitle)", for: .normal)
            leftButton.setTitleColor(leftbuttonTitleColor, for: .normal)
            return
        }
        
        // Setting custom image
        guard leftButtonImage == nil else {
            leftButton.setTitle("", for: .normal)
            leftButton.setImage(leftButtonImage, for: .normal)
            return
        }
        
        //System default cancel image
        leftButton.setImage(getCancelImage(), for: .normal)
    }
    
    func getCancelImage() -> UIImage {
        return UIImage(named: "Cancel.png", in: FeedbackService.getBundle(), compatibleWith: nil)!
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
        
        let param = FeedbackHelper().getParam(forLoopKey: loopToDoKey, text: text, params: feedbackPayload)
        
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
