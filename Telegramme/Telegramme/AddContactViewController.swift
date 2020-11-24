//
//  AddContactViewController.swift
//  Telegramme
//
//  Created by hwen on 11/11/20.
//

import Foundation
import UIKit

class AddContactViewController : UIViewController{
    
    @IBOutlet weak var firstNameFld: UITextField!
    @IBOutlet weak var lastNameFld: UITextField!
    @IBOutlet weak var mobileFld: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    let contactController = ContactController()
    
    var contactIndex:Int?
    var originalContact:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = contactIndex{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let contact = appDelegate.contactList[index]
            firstNameFld.text = contact.firstName
            lastNameFld.text = contact.lastName
            mobileFld.text = contact.mobileNo
            originalContact = contact.mobileNo
            
            updateBtn.isHidden = false
            backBtn.isHidden = false
        }else{
            updateBtn.isHidden = true
            backBtn.isHidden = true
        }
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        firstNameFld.text = ""
        lastNameFld.text = ""
        mobileFld.text = ""
    }
    
    @IBAction func createBtn(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contact = Contact(firstNameFld.text!, lastNameFld.text!, mobileFld.text!)
        contactController.AddContact(newContact: contact)
            
        // update the contact list after add a new contact
        appDelegate.contactList = contactController.retrieveAllContact()
    
        firstNameFld.text = ""
        lastNameFld.text = ""
        mobileFld.text = ""
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contact = Contact(firstNameFld.text!, lastNameFld.text!, mobileFld.text!)
        contactController.updateContact(mobileno: originalContact!, newContact: contact)
        
        // update the contact list after update a contact
        appDelegate.contactList = contactController.retrieveAllContact()
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
