//
//  ViewController.swift
//  FullFeedback
//
//  Created by karthikAdaptavant on 11/22/2017.
//  Copyright (c) 2017 karthikAdaptavant. All rights reserved.
//

import UIKit
import FullFeedback

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
	  
        FullTaskLogger.CanLog = true
        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjY4MGZjMTNkZWEwMjhhODJkM2I4NjcxZDJlN2NhZjMyZTM0NmU3ZjkifQ.eyJpc3MiOiJodHRwczovL2Z1bGxjcmVhdGl2ZS5mdWxsYXV0aC5jb20iLCJpYXQiOjE1OTQ0ODg5MzEsInByb2pfaWQiOiJhbnl3aGVyZXdvcmtzIiwidHlwZSI6InVzZXIiLCJzdWIiOiIwM2UzMGU0My0xNzYyLTRlNzEtYTI3My02OGY2NDg0Yjg5NTUiLCJleHAiOjE1OTUwOTM3MzEsImp0aSI6IjZmNzI2MFU3Y0F5Q3ZnQ1UifQ.vIpw1pIUQHKYCE3NvqGWFlGT_wzA7pAyLw2c0QsAwrnRcPe_enHs3mctM2cgA78jQbMt5KVrYKHqkLtZgmGXMpYOMpYmwT42j4_21ugi4tjz9HXc9d3sXWH8O2ldh__KRkNqBasvqFoCnJ2kTkB7w_gtm4dt_v1HYwQtQjSbW520GriIjcrNB1ntQW4l--BwA3uGmhdSCwslctsCeScPtywRctv0XSwtjftmVizaCrKscCUfs9aSgK9xIsARMBlkGQtPpzIBXlMLr3YFJnjwU6RKEQs280GpdLpg1ZVlywZbquCuVk673w1Ein7K4fc5O_VtNNYZiDRFGgMsiGB-1A"

        let param = TaskParam(department: "a39be3a8-5330-48e8-bd78-1d8b23a9ee5e", departmentId: "486a0382-b82c-4c4c-9e15-4051f58eeaba", type: "05a4bfd6-78f6-4145-8540-d7972e53fbda", source: "Connect.aw - iOS", accessToken: accessToken, emailId: "sathish.gurunathan@anywhere.co", brandId: "00937b73-9788-4706-add0-8efdb6aa1684")
        var apiConstants: TaskApiConstants = TaskApiConstants(mode: .live)
        apiConstants.add(apiKey: "SEN42")

        guard let feedbackVc = FeedbackViewController.initialize(param: param, taskType: .dsTask, apiConstants: apiConstants) else { return }
        feedbackVc.statusBarStyle = .lightContent
        self.present(feedbackVc, animated: true, completion: nil)
    }
}
