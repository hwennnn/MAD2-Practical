//
//  AddSafeEntryViewController.swift
//  SafeEntry
//
//  Created by hwen on 15/12/20.
//

import Foundation
import UIKit

class AddSafeEntryViewController : UIViewController{
    
    @IBOutlet weak var txtMainLocation: UITextField!
    @IBOutlet weak var txtMInorLocation: UITextField!
    
    let safeController = SafeEntryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addNewLocation(_ sender: Any) {
        if !txtMainLocation.text!.isEmpty{
            let mainLocation = txtMainLocation.text!
            let minorLocation = txtMInorLocation.text!
            let date = Date()
            let safeEntry = SafeEntry(date, mainLocation, minorLocation)
            safeController.AddSafeEntryData(s: safeEntry)
            
            txtMainLocation.text = ""
            txtMInorLocation.text = ""
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
