//
//  ViewController.swift
//  Practical3
//
//  Created by hwen on 3/11/20.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var txtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func onClick(_ sender: Any) {
        print("I'm clicked!")
        myLabel.text = "Button has been clicked!"
    }
    
    func textFieldShouldReturn(_ txtField:UITextField) -> Bool{
        txtField.resignFirstResponder()
        myLabel.text = txtField.text
        return true
    }
    
}

