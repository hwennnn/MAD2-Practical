//
//  FriendController.swift
//  Telegramme
//
//  Created by hwen on 26/11/20.
//

import Foundation
import UIKit
import CoreData

class FriendController: UIViewController{
    
    func AddFriend(friend: Friend){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistenetContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDFriend", in: context)!
        
        let newFriend = NSManagedObject(entity: entity, insertInto: context)
        newFriend.setValue(friend.name, forKey: "name")
        newFriend.setValue(friend.profileImageName, forKey: "profileImageName")
        
        do{
            try context.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func AddMessageToFriend(friend:Friend, message:Message){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistenetContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)!
        let newMessage = NSManagedObject(entity: entity, insertInto: context)
        newMessage.setValue(message.date, forKey: "date")
        newMessage.setValue(message.isSender, forKey: "isSender")
        newMessage.setValue(message.text, forKey: "text")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFriend")
        fetchRequest.predicate = NSPredicate(format: "name = %@", friend.name)
        
        do{
            let fetched = try context.fetch(fetchRequest)
            let f = fetched[0]
            newMessage.setValue(f, forKey: "friend")
            
            do{
                try context.save()
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func retrieveMessagesbyFriend(friend:Friend)->[Message]{
        var msgList:[Message] = []
        var fetchedList:[NSManagedObject] = []
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistenetContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFriend")
        fetchRequest.predicate = NSPredicate(format: "name = %@", friend.name)
        
        do {
            fetchedList = try context.fetch(fetchRequest)
            
            for f in fetchedList{
                let msg = f.value(forKey: "message") as! NSManagedObject
                let text = msg.value(forKey: "text") as! String
                let isSender = msg.value(forKey: "isSender") as! Bool
                let date = msg.value(forKey: "date") as! Date
                let messageObj = Message(text,isSender,date)
                msgList.append(messageObj)
                
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        return msgList
    }
}
