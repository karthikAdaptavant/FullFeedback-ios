//
//  ViewController.swift
//  FullFeedback
//
//  Created by karthikAdaptavant on 11/22/2017.
//  Copyright (c) 2017 karthikAdaptavant. All rights reserved.
//

import UIKit
import FullFeedback
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func feedbackBtnAct(_ sender: Any) {
        
        let accessToken = ""  
        let feedBackSign = "<br><br>----------<b>App Data</b>-----------<br> <br>------------<b>User Info</b>----------<br> <b>LoginId</b> - sathish.gurunathan@anywhere.co<br> <b>UserName</b> - sathish<br> <b>UniquePin</b> - Test<br> <b>TimeZone</b> - In/kolkata - 05:30<br> <br>------------<b>App Info</b>----------<br> <b>AppVersion</b> - v1.0(1.3)<br> <b>AppEnvironment</b> - TestLive<br> <b>Brand ID</b> - TestBrandID<br> <br>------------<b>Device Info</b>----------<br> <b>Model</b> - iPhone<br> <b>DeviceType</b> - Test<br> <b>Version</b> - iOS 11.1.1<br> <b>DeviceName</b> - iPhone<br> <b>Device ID</b> - TestID<br>"
        
        let dsAwParmaHelper = DSParamHelper(department: "you dept", departmentId: "your dept id", type: "pass your type here", source: "pass your source here", accessToken: "", emailId: "", brandId: "")        
        guard let feedbackVc = FeedbackViewController.initialize(dsParamHelper: dsAwParmaHelper, appType: .awFeedback, feedbackInfo: feedBackSign) else {
            return
        }
        
        feedbackVc.statusBarStyle = .lightContent        
        self.present(feedbackVc, animated: true, completion: nil)
    }
    
}
