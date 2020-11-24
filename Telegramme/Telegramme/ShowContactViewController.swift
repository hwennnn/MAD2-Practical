//
//  ShowContactViewController.swift
//  Telegramme
//
//  Created by hwen on 12/11/20.
//

import Foundation
import UIKit

class ShowContactViewController : UITableViewController{
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let contactController = ContactController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData() //refresh data
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let contact = appDelegate.contactList[indexPath.row]
        cell.textLabel!.text = "\(contact.firstName) \(contact.lastName)"
        cell.detailTextLabel!.text = "\(contact.mobileNo)"
        
        return cell
         
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editHandler(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.editHandler(indexPath.row)
                                            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [action])

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let contact = self.appDelegate.contactList[indexPath.row]
            
            contactController.deleteContact(mobileno: contact.mobileNo)
            
            // update the contact list after remove a contact
            appDelegate.contactList = contactController.retrieveAllContact()
            
        } else if editingStyle == UITableViewCell.EditingStyle.insert {
         }
        
        self.tableView.reloadData()
    }
    
    func editHandler(_ index: Int){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Content", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "newContact") as! AddContactViewController
        newViewController.contactIndex = index
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
}
