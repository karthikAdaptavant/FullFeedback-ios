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
        
        //        guard let feedbackvc = FeedbackViewController.initialize(loopToDoKey: "agtzfmxvb3BhYmFja3IRCxIETG9vcBiAgKDBl8iYCww", feedbackCardTitle: "Test Pod Feedback") else {
        //            return
        //        }
        //
        //        feedbackvc.statusBarStyle = .lightContent
        //        feedbackvc.userName = "Venkata vamsi"
        //        feedbackvc.userEmail = "venkata.vamsi@full.co"
        //
        //        feedbackvc.appInfo = ["appVersion": 11, "appName": "MyApp"]
        //        feedbackvc.deviceInfo = ["deviceaaa": "dfsfe"]
        //        feedbackvc.userInfo = ["Name": "vamsi"]
        //
        //        self.present(feedbackvc, animated: true, completion: nil)
        
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2Z1bGxjcmVhdGl2ZS5mdWxsYXV0aC5jb20iLCJpYXQiOjE1NDUwMTg0MjQsInByb2pfaWQiOiJhbnl3aGVyZXdvcmtzIiwic3ViIjoiMDNlMzBlNDMtMTc2Mi00ZTcxLWEyNzMtNjhmNjQ4NGI4OTU1IiwiZXhwIjoxNTQ1NjIzMjI0LCJqdGkiOiJmYzhhMzdxRmdjU2dsb1FBIn0.hygYwpbuahKSLvD79W9oUKI1_kWMJZitM-3RKO-GVyE"
        
        //        let dsParamHelper = DSParamHelper(department: "783bf7cd-ba1a-4ba6-b3bf-ffb7cdb2540f", departmentId: "486a0382-b82c-4c4c-9e15-4051f58eeaba", brandId: "d56194e1-b98b-4068-86f8-d442777d2a16", type: "06807d6a-c4d1-4831-8291-de283f67d140", source: "YoCoBoard iOS", accessToken: accessToken, emailId: "sathish.gurunathan@anywhere.co", accountIds: ["91dfed2f-d29f-4302-89ee-341e9364b941"], userName: "Sathish", documents: nil)
        
        let feedBackSign = "<br><br>----------<b>App Data</b>-----------<br> <br>------------<b>User Info</b>----------<br> <b>LoginId</b> - sathish.gurunathan@anywhere.co<br> <b>UserName</b> - sathish<br> <b>UniquePin</b> - Test<br> <b>TimeZone</b> - In/kolkata - 05:30<br> <br>------------<b>App Info</b>----------<br> <b>AppVersion</b> - v1.0(1.3)<br> <b>AppEnvironment</b> - TestLive<br> <b>Brand ID</b> - TestBrandID<br> <br>------------<b>Device Info</b>----------<br> <b>Model</b> - iPhone<br> <b>DeviceType</b> - Test<br> <b>Version</b> - iOS 11.1.1<br> <b>DeviceName</b> - iPhone<br> <b>Device ID</b> - TestID<br>"
        
        let dsAwParmaHelper = DSParamHelper(department: "85bc57f0-8628-41f3-82e5-42fc0836883c", departmentId: "486a0382-b82c-4c4c-9e15-4051f58eeaba", brandId: "0db91e28-1e09-4420-9390-faac4ab2c931", type: "ae3dd607-c06c-4ecd-8c2a-27507e7e77dd", source: "ios feedback", accessToken: accessToken, emailId: "sathish.gurunathan@anywhere.co")
        
        
        guard let feedbackVc = FeedbackViewController.initialize(dsParamHelper: dsAwParmaHelper, appType: .awFeedback, feedbackInfo: feedBackSign) else {
            return
        }
        
        feedbackVc.statusBarStyle = .lightContent        
        self.present(feedbackVc, animated: true, completion: nil)
    }
    
}
