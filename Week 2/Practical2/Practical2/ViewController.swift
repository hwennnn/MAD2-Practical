//
//  ViewController.swift
//  Practical2
//
//  Created by hwen on 27/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var text1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var friendList = [Friend]()
        friendList.append(Friend(firstname: "jeya", lastname: "vishnu", age: 20))
        friendList.append(Friend(firstname: "zac", lastname: "hong", age: 19))
        friendList.append(Friend(firstname: "run", lastname: "lin", age: 22))
        friendList.append(Friend(firstname: "hwen", lastname: "wai", age: 19))
        friendList.append(Friend(firstname: "quan", lastname: "sheng", age: 36))
        
        displayList(friendList)
        displayFriendsUnder20(friendList)
        print("The average age is \(findAverageAge(friendList))")
        
    }
    
    func displayList(_ friendList:[Friend]){
        for friend in friendList{
            print(friend.description)
        }
    }
    
    func displayFriendsUnder20(_ friendList:[Friend]){
        print("The names of Friend objects whose age is less than 20:")
        for friend in friendList{
            if friend.age < 20{
                print("\(friend.firstName) \(friend.lastName)")
            }
        }
    }
    
    func findAverageAge(_ friendList:[Friend])->Double {
        var c = 0
        for friend in friendList{
            c += friend.age
        }
        return Double(c) / Double(friendList.count)
    }
    


}

