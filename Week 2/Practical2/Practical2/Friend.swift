//
//  Friend.swift
//  Practical2
//
//  Created by hwen on 27/10/20.
//

import Foundation

class Friend{
    var firstName: String = ""
    var lastName: String = ""
    var age: Int = 0
    
    public var description: String { return "\(firstName) \(lastName)'s age is \(age)" }
    
    init(firstname:String, lastname:String, age:Int){
        self.firstName = firstname
        self.lastName = lastname
        self.age = age
    }
}
