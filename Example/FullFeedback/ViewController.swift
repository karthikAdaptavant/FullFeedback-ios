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
        
        let dsParamHelper = DSParamHelper(department: "", departmentId: "", brandId: "", type: "", source: "", accessToken: accessToken, emailId: "", accountIds: [""], userName: "", documents: nil)
        
        
        guard let feedbackVc = FeedbackViewController.initialize(dsParamHelper: dsParamHelper) else {
            return
        }
        
        feedbackVc.statusBarStyle = .lightContent
        feedbackVc.appInfo = ["appVersion": 11, "appName": "MyApp"]
        feedbackVc.userInfo = ["Name": "Sathish"]
        
        self.present(feedbackVc, animated: true, completion: nil)
    }
    
}
