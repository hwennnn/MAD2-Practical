//
//  Message.swift
//  Telegramme
//
//  Created by hwen on 26/11/20.
//

import Foundation

class Message{
    var text: String
    var isSender: Bool
    var date: Date
    
    init(_ Text:String, _ IsSender:Bool, _ dDate:Date) {
        text = Text
        isSender = IsSender
        date = dDate
    }
}
