//
//  File.swift
//  SafeEntry
//
//  Created by Charles on 4/12/20.
//

import Foundation
import CoreData
import UIKit

class SafeEntryController {
    
    func SafeEntryDataExist()->Bool {
        var result = false
        //TODO: Question 1(b)(i) check the Core Data if any data exists.
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
    
        let fetchRequest = NSFetchRequest<CD_CheckIn>(entityName: "CD_CheckIn")
        do {
            let checkins:[CD_CheckIn] = try context.fetch(fetchRequest)
            
            for _ in checkins{
                result = true
            }
            

        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return result
    }
    
    func FetchSafeEntryData()->[SafeEntry] {
        var safeEntryList:[SafeEntry] = []
        var checkIn:[NSManagedObject] = []
        
//        var datetime:Date
//        var mainvenue:String
//        var minorvenue:String
        //TODO: Question 1(b)(ii) fetch all data in the Core Data and convert the data to SafeEntry list
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
    
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CD_CheckIn")
        do {
            checkIn = try context.fetch(fetchRequest)
        
            for c in checkIn{
                let main = c.value(forKeyPath: "cd_mainvenue") as? String
                let minor = c.value(forKeyPath: "cd_minorvenue") as? String
                let date = c.value(forKeyPath: "cd_datetime") as? Date
        
                let aCheckIn = SafeEntry(date!,main!,minor!)
                safeEntryList.append(aCheckIn)
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        return safeEntryList
    }
    
    func AddSafeEntryData(s:SafeEntry){
        //TODO: Question 1(b)(iii)  takes in a SafeEntry object and write to the Core Data
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CD_CheckIn", in: context)!
        
        let safeEntry = NSManagedObject(entity: entity, insertInto: context) as! CD_CheckIn
        safeEntry.setValue(s.mainvenue, forKey: "cd_mainvenue")
        safeEntry.setValue(s.minorvenue, forKey: "cd_minorvenue")
        safeEntry.setValue(s.datetime, forKey: "cd_datetime")
        
        do{
            try context.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    init() {}
    
}
