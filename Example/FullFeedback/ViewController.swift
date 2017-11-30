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
        
        let params = ["ApplicationInfo": ["version": 1, "login": "vamsi"],
                      "DeviceInfo": ["DeviceName": "mymobile", "DeviceOsVersion": 11.2]]
        
        let obj = FeedbackHelper()

        guard let feedbackvc = obj.getFeedbackViewController(loopToDoKey: "agtzfmxvb3BhYmFja3IRCxIETG9vcBiAgKDBiamNCgw", params: params) else {
            return
        }
        
        self.present(feedbackvc, animated: true, completion: nil)
    }
}

