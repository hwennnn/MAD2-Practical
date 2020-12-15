//
//  CheckInTableViewController.swift
//  SafeEntry
//
//  Created by hwen on 15/12/20.
//

import Foundation
import UIKit

class CheckInTableViewController : UITableViewController{
    
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    var safeEntryList:[SafeEntry] = []
    let safeController = SafeEntryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.safeEntryList = safeController.FetchSafeEntryData()
        
        self.tableView.reloadData() //refresh data
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.safeEntryList = safeController.FetchSafeEntryData()
        self.tableView.reloadData() //refresh data
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return safeEntryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)

        let safeEntry = safeEntryList[indexPath.row]

        cell.textLabel!.text = "\(safeEntry.mainvenue), \(safeEntry.minorvenue)"
        cell.detailTextLabel!.text = dateFormat(safeEntry.datetime)

        return cell
         
    }
    
    func dateFormat(_ date:Date) -> String
    {
        let dateFormatter = DateFormatter() // set to local date (Singapore)
        dateFormatter.locale = Locale(identifier: "en_SG") // set desired format, note a is AM and FM format
        dateFormatter.dateFormat = "d MMM yyyy h:mm a" // convert date to String
        let datevalue = dateFormatter.string(from: date)
        
        return datevalue
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let safeEntry = safeEntryList[indexPath.row]
        appDelegate.safeEntry = safeEntry
    }
     
}
