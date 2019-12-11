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
	  
        let param = TaskParam(department: "you dept", departmentId: "your dept id", type: "pass your type here", source: "pass your source here", accessToken: "", emailId: "", brandId: "")
		var apiConstants: TaskApiConstants = TaskApiConstants(mode: .live)
		apiConstants.add(apiKey: "your api key")
				 
		guard let feedbackVc = FeedbackViewController.initialize(param: param, taskType: .awTask, apiConstants: apiConstants) else { return }
        feedbackVc.statusBarStyle = .lightContent        
        self.present(feedbackVc, animated: true, completion: nil)
    }    
}
