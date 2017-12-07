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
        
        let obj = FeedbackHelper()

        guard let feedbackvc = obj.getFeedbackViewController(loopToDoKey: "agtzfmxvb3BhYmFja3IRCxIETG9vcBiAgKDBiamNCgw") else {
            return
        }
        
        feedbackvc.leftButtonTitle = "Cancel"
        feedbackvc.leftbuttonTitleColor = .white
        feedbackvc.rightButtonTitlecolor = .white
        feedbackvc.titleColor = .white
        feedbackvc.navBarColor = UIColor.purple
        feedbackvc.statusBarStyle = .lightContent
        
        var feedbackload = FeedbackPayload()
        feedbackload.appLogin = "test"
        feedbackload.appVersion = "0.2.2"
        feedbackload.deviceModel = ""
        feedbackvc.feedbackPayload = feedbackload

        self.present(feedbackvc, animated: true, completion: nil)
    }
}

