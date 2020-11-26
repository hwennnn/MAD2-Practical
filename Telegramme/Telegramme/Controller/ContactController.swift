//
//  ContactController.swift
//  Telegramme
//
//  Created by hwen on 24/11/20.
//

import UIKit
import Foundation
import CoreData

class ContactController: UIViewController {
    
    // Add a new contact to Core Data
    func AddContact(newContact:Contact){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistenetContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDContact", in: context)!
        
        let contact = NSManagedObject(entity: entity, insertInto: context)
        contact.setValue(newContact.firstName, forKey: "firstname")
        contact.setValue(newContact.lastName, forKey: "lastname")
        contact.setValue(newContact.mobileNo, forKey: "mobileno")
        
        do{
            try context.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Retrieve all contact from Core Data
    func retrieveAllContact() -> [Contact] {
        var contactList:[Contact] = []
        var fetchedList:[NSManagedObject] = []
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistenetContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        do {
            fetchedList = try context.fetch(fetchRequest)
            
            for c in fetchedList{
                let firstname = c.value(forKeyPath: "firstname") as? String
                let lastname = c.value(forKey: "lastname") as? String
                let mobileno = c.value(forKey: "mobileno") as? String
                let contact = Contact(firstname!, lastname!, mobileno!)
                contactList.append(contact)
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return contactList
    }
    
    // Update current contact with new contact
    // fetch data based on mobileno
    func updateContact(mobileno:String, newContact:Contact){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistenetContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        
        fetchRequest.predicate = NSPredicate(format: "mobileno = %@", mobileno)
        do {
            let fetched = try context.fetch(fetchRequest)
            
            let contact = fetched[0] as NSManagedObject
            contact.setValue(newContact.firstName, forKey: "firstname")
            contact.setValue(newContact.lastName, forKey: "lastname")
            contact.setValue(newContact.mobileNo, forKey: "mobileno")
            
            do{
                try context.save()
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // Delete contact
    // fetch data based on mobileno
    func deleteContact(mobileno:String){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistenetContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        
        fetchRequest.predicate = NSPredicate(format: "mobileno = %@", mobileno)
        
        do {
            let fetched = try context.fetch(fetchRequest)
        
            let contact = fetched[0] as NSManagedObject
            context.delete(contact)
            
            do{
                try context.save()
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
}
