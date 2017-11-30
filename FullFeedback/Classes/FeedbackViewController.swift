//
//  FeedbackViewController.swift
//  FullFeedback
//
//  Created by Karthik on 11/22/17.
//
import UIKit

open class FeedbackViewController: UIViewController {
    
    var loopToDoKey = String()

    @IBOutlet weak var textField: UITextField!
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button(_ sender: UIButton) {
        FeedbackHelper.constructLoopToDoURL(feedbackText: textField.text!)
    }
    
}
