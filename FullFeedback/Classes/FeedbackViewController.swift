 //
//  FeedbackViewController.swift
//  FullFeedback
//
//  Created by Karthik on 11/22/17.
//

import UIKit
import MBProgressHUD

class FeedbackService {
    
    static func getBundle() -> Bundle {
        
        let podBundle = Bundle(for: FeedbackViewController.self)
        
        guard let bundleUrl = podBundle.url(forResource: "FullFeedback", withExtension: "bundle") else {
            fatalError()
        }
        
        guard let bundle = Bundle(url: bundleUrl) else {
            fatalError()
        }
        
        return bundle
    }    
}

open class FeedbackViewController: UIViewController, UITextViewDelegate, KeyboardListenerDelegate {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var setFeedbackTitle: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var navBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var feedbackTextBottomconstraint: NSLayoutConstraint!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var loopToDoKey: String = String()
    var feedbackCardTitle: String = String()
    
    open var userInfo: [String: Any] = [:]
    open var appInfo: [String: Any] = [:]
    open var deviceInfo: [String: Any] = [:]
    open var userName: String?
    open var userEmail: String?
    
    open var navBarColor: UIColor = UIColor(rawRGBValue: 63, green: 72, blue: 87, alpha: 1)
    open var titleColor: UIColor = UIColor.white
    open var leftButtonImage : UIImage?
    open var leftButtonTitle : String = String()
    open var leftButtonTitleColor : UIColor =  UIColor.white
    open var rightButtonImage : UIImage?
    open var rightButtonTitle : String = String()
    open var rightButtonTitleColor: UIColor = UIColor(rawRGBValue: 118, green: 214, blue: 255, alpha: 1)
    open var segmentControlBgColor: UIColor = UIColor.white
    open var segmentControlTintColor: UIColor = UIColor(rawRGBValue: 63, green: 72, blue: 87, alpha: 1)
    open var statusBarStyle: UIStatusBarStyle = .default

    var alertHud: MBProgressHUD!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
        leftButtonProperties()
        rightButtonProperties()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    func setup() {
        
        self.alertHud =  self.getAlertHUD(srcView: self.view)
        self.feedbackTextView.delegate = self
        AppKeyboardListener.delegate = self
        self.feedbackTextView.becomeFirstResponder()
        
        self.feedbackTextView.layer.cornerRadius = 6
        self.feedbackTextView.clipsToBounds = true
        
        self.titleText.textColor = titleColor
        self.navbarView.backgroundColor = navBarColor
        
        self.segmentedControl.backgroundColor = segmentControlBgColor
        self.segmentedControl.tintColor = segmentControlTintColor
        
        self.segmentedControl.selectedSegmentIndex = 0
        self.feedbackLabel.text = "What's your suggestion?"
        
        self.navBarViewHeight.constant = (UIDevice.current.isIphoneX) ? 74 : 64
    }
    
    func leftButtonProperties(){
        
        // Setting Custom title
        guard leftButtonTitle.isEmpty else {
            leftButton.setImage(nil, for: .normal)
            leftButton.setTitle(" \(leftButtonTitle)", for: .normal)
            leftButton.setTitleColor(leftButtonTitleColor, for: .normal)
            return
        }
        
        // Setting custom image
        guard leftButtonImage == nil else {
            leftButton.setTitle("", for: .normal)
            leftButton.setImage(leftButtonImage, for: .normal)
            return
        }
        
        //System default leftButton title
        leftButton.setTitle("Cancel", for: .normal)
        leftButton.setTitleColor(leftButtonTitleColor, for: .normal)
    }
    
    func rightButtonProperties(){
        
        // Setting Custom title
        guard rightButtonTitle.isEmpty else {
            rightButton.setImage(nil, for: .normal)
            rightButton.setTitle(" \(rightButtonTitle)", for: .normal)
            rightButton.setTitleColor(rightButtonTitleColor, for: .normal)
            return
        }
        
        // Setting custom image
        guard rightButtonImage == nil else {
            rightButton.setTitle("", for: .normal)
            rightButton.setImage(rightButtonImage, for: .normal)
            return
        }
        
        //System default rightButton title
        rightButton.setTitle("Send", for: .normal)
        rightButton.setTitleColor(rightButtonTitleColor, for: .normal)
        
    }
    
    @IBAction func feedbackType(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        
        case 1:
            feedbackLabel.text = "Please describe your problem."
        case 2:
            feedbackLabel.text = "Ask your question here."
        default:
            feedbackLabel.text = "What's your suggestion?"
        }
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
    
    open class func initialize(loopToDoKey key: String, feedbackCardTitle cardTitle: String) -> FeedbackViewController? {
        
        let bundle = FeedbackService.getBundle()
        let storyboard = UIStoryboard(name: "Feedback", bundle: bundle)
        
        guard let feedbackVc = storyboard.instantiateViewController(withIdentifier: "FeedbackViewController") as? FeedbackViewController else {
            print("Error: Feedback viewcontroller not found")
            return nil
        }
        
        feedbackVc.loopToDoKey = key
        feedbackVc.feedbackCardTitle = cardTitle
        
        return feedbackVc
    }
    
    @IBAction func cancelFeedbackvc(_ sender: UIButton) {
        feedbackTextView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendFeedbackButton(_ sender: UIButton) {
        
        guard let text = feedbackTextView.text, !text.isEmpty else {
            return
        }
        
        let constructedDeviceInfo = constructDeviceInfo()
        for (key, value) in constructedDeviceInfo {
            deviceInfo.updateValue(value, forKey: key)
        }
        
        self.feedbackTextView.resignFirstResponder()
        self.postFeedback(forText: text)
    }
    
    func constructDeviceInfo() -> [String: Any] {
        return  ["Model": UIDevice.current.model,"DeviceType": UIDevice.current.modelName, "SystemName": UIDevice.current.systemName, "Version": UIDevice.current.systemVersion, "DeviceName": UIDevice.current.name]
    }
    
    func postFeedback(forText text: String) {
        
        self.alertHud.showLoader(msg: "Sending....")
        
        let param = FeedbackHelper().getParam(forLoopKey: loopToDoKey, text: text,cardTitle: feedbackCardTitle, userInfo: userInfo, appInfo: appInfo, deviceInfo: deviceInfo, userName: userName ?? "", userEmail: userEmail ?? "", selectedIndexTag: segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!)
        
        FeedbackHelper().postFeedback(withParam: param ) { (success) in
            
            guard success else {
                self.alertHud.showText(msg: "Something went wrong!", detailMsg: "Please ", delay: 1.9)
                return
            }
            
            self.alertHud.showText(msg: "Feedback sent Successfully ", detailMsg: "", delay: 1.9)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.feedbackTextView.resignFirstResponder()
                dismissFeedbackvc()
            })
        }
        
        func dismissFeedbackvc() {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

public extension UIColor {

    public convenience init(rawRGBValue red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {

        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
