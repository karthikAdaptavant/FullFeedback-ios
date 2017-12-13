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
        
        guard let feedbackvc = FeedbackViewController.initialize(loopToDoKey: "agtzfmxvb3BhYmFja3IRCxIETG9vcBiAgKDBl8iYCww", feedbackCardTitle: "Test Pod Feedback") else {
            return
        }
        
        feedbackvc.statusBarStyle = .lightContent
        feedbackvc.userName = "Venkata vamsi"
        feedbackvc.userEmail = "venkata.vamsi@full.co"
        
        feedbackvc.appInfo = ["appVersion": 11, "appName": "MyApp"]
        feedbackvc.deviceInfo = ["deviceaaa": "dfsfe"]
        feedbackvc.userInfo = ["Name": "vamsi"]
     
        self.present(feedbackvc, animated: true, completion: nil)
    }
}

