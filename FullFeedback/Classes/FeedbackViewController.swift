 //
 //  FeedbackViewController.swift
 //  FullFeedback
 //
 //  Created by Karthik on 11/22/17.
 //
 
 import UIKit
 import MBProgressHUD
 
 open class FeedbackViewController: UIViewController, UITextViewDelegate, KeyboardListenerDelegate {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var setFeedbackTitle: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var navBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var leftBarButtonTopConst: NSLayoutConstraint!
    @IBOutlet weak var rightBarButtonTopConst: NSLayoutConstraint!
    @IBOutlet weak var feedbackLblTopConst: NSLayoutConstraint!
    @IBOutlet weak var feedbackTextBottomconstraint: NSLayoutConstraint!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
        
    open var userInfo: [String: Any] = [:]
    open var appInfo: [String: Any] = [:]
    open var deviceInfo: [String: Any] = [:]
    
    open var navBarColor: UIColor = UIColor(rawRGBValue: 63, green: 72, blue: 87, alpha: 1)
    open var titleColor: UIColor = UIColor.white
    open var leftButtonImage : UIImage?
    open var leftButtonTitle : String = String()
    open var leftButtonTitleColor : UIColor =  UIColor.white
    open var rightButtonImage : UIImage?
    open var rightButtonTitle : String = String()
    open var rightButtonTitleColor: UIColor = UIColor.white
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
        
        // To change the navbar height for iphonex
        let isXdevice: Bool = UIDevice.current.isXDevice
        self.navBarViewHeight.constant = isXdevice ? 84 : 64
        
        // To change the navbar Top cons for iphonex
        var topConsHeight: CGFloat = isXdevice ? 30 : 20
        self.leftBarButtonTopConst.constant = topConsHeight
        self.rightBarButtonTopConst.constant = topConsHeight
        self.feedbackLblTopConst.constant = topConsHeight
        
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
    
	open class func initialize(param: TaskParam, taskType: TaskType, apiConstants: TaskApiConstants) -> FeedbackViewController? {
        
		guard let feedbackVc = FullTaskUtils.getFullTaskViewController() else {
			fullTaskLogError("Feedback viewcontroller not found")
            return nil
        }
	   		
		let fullTaskService = FullTaskService.shared
		fullTaskService.assign(param: param)
		fullTaskService.assign(taskType: taskType)
		fullTaskService.assign(apiConstants: apiConstants)
        return feedbackVc
    }
    
    @IBAction func cancelFeedbackvc(_ sender: UIButton) {
        feedbackTextView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendFeedbackButton(_ sender: UIButton) {
        
        guard let text = feedbackTextView.text, !text.isEmpty else {
            self.alertHud.showText(msg: "Please, Enter some Feedback", delay: 1.9)
            return
        }
        
        self.feedbackTextView.resignFirstResponder()
        self.postFeedback(forText: text)
    }
    
    func dismissFeedbackvc() {
        self.dismiss(animated: true, completion: nil)
    }
	
	deinit {
		fullTaskLogMessage("Deinited")
	}
 }

// MARK: Feedback Posting
extension FeedbackViewController {
	
	func postFeedback(forText text: String) {
		
		self.alertHud.showLoader(msg: "Sending....")
		let fullTaskService = FullTaskService.shared
		let content = TaskContent(feedbackContent: text, feedbackSignature: fullTaskService.taskParam.taskSignature)
		fullTaskService.assign(content: content)
		
        do {
            try fullTaskService.postFeedback { [weak self] (success) in
                DispatchQueue.main.async { [weak self] in
                    switch success {
                        case false:
                            self?.alertHud.showText(msg: "Something went wrong!", detailMsg: "", delay: 1.9)

                        case true:
                            self?.alertHud.showText(msg: "Feedback sent Successfully ", detailMsg: "", delay: 1.9)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
                                self?.feedbackTextView.resignFirstResponder()
                                self?.dismissFeedbackvc()
                            })
                    }
                }
            }
        } catch let error {
			fullTaskLogError(error)
			self.alertHud.showText(msg: "Something went wrong!" , detailMsg: "", delay: 1.9)
		}
	}
}
