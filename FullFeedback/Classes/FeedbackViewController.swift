//
//  FeedbackViewController.swift
//  FullFeedback
//
//  Created by Karthik on 11/22/17.
//
import UIKit

open class FeedbackViewController: UIViewController {
    
    var loopToDoKey: String = ""
    var params: [String : Any] = [:]

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
        
        self.postFeedback(forText: textField.text!)
    }
    
    func postFeedback(forText text: String) {

        // show loader
        let param = FeedbackHelper().getParam(forLoopKey: loopToDoKey, text: text, params: params)
        FeedbackHelper().postFeedback(withParam: param ) { (success) in

            guard success else {
                //show alert
                return
            }

            // show success message

            // dimiss the view
        }
    }
}
