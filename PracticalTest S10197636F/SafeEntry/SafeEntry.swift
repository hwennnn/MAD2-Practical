//
//  SafeEntry.swift
//  SafeEntry
//
//  Created by Charles on 4/12/20.
//

import Foundation

class SafeEntry {
    
    var datetime:Date
    var mainvenue:String
    var minorvenue:String
    
    init(_ datetime:Date,_ mainvenue:String,_ minorvenue:String) {
        self.datetime = datetime
        self.mainvenue = mainvenue
        self.minorvenue = minorvenue
    }
    
}
