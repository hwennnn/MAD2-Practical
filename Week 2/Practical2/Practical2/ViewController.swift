//
//  ViewController.swift
//  Practical2
//
//  Created by hwen on 27/10/20.
//

import UIKit

class ViewController: UIViewController {

    var friendList = [Friend]()
    @IBOutlet weak var text1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendList.append(Friend(firstname: "jeya", lastname: "vishnu", age: 20, description: "Diploma CSF"))
        friendList.append(Friend(firstname: "zac", lastname: "hong", age: 19, description: "Diploma IT"))
        friendList.append(Friend(firstname: "run", lastname: "lin", age: 22, description: "programmer"))
        friendList.append(Friend(firstname: "hwen", lastname: "wai", age: 19, description: ""))
        friendList.append(Friend(firstname: "quan", lastname: "sheng", age: 36, description: ""))
        
        displayList()
        displayFriendsUnder20()
        print("The average age is \(findAverageAge())")
        
    }
    
    func displayList(){
        for friend in friendList{
            print("\(friend.firstName) \(friend.lastName) (\(friend.description))'s age is \(friend.age)")
        }
    }
    
    func displayFriendsUnder20(){
        print("The names of Friend objects whose age is less than 20:")
        for friend in friendList{
            if friend.age < 20{
                print("\(friend.firstName) \(friend.lastName)")
            }
        }
    }
    
    func findAverageAge()->Double {
        var c = 0
        for friend in friendList{
            c += friend.age
        }
        return Double(c) / Double(friendList.count)
    }
    


}

