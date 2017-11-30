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
        
        guard let feedbackvc = FeedbackHelper.getFeedbackViewController(loopToDoKey: "agtzfmxvb3BhYmFja3IRCxIETG9vcBiAgKDBiamNCgw") else {
            return
        }
        
        
        self.present(feedbackvc, animated: true, completion: nil)
        
    }
}

