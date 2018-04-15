//
//  User.swift
//  Neighborly
//
//  Created by Other users on 4/14/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit
import os.log
import SendBirdSDK


struct PropertyKey {
    static let userID = "userID"
    static let name = "name"
    static let email = "email"
    static let myItems = "myItems"
    static let borrowedItems = "borrowedItems"
}



class User: NSObject, NSCoding{
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("user")
    
    public func saveUser() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self, toFile: User.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("User successfully saved.", log: OSLog.default, type: .debug)
            print("user succesfully saved")
        } else {
            os_log("Failed to save user...", log: OSLog.default, type: .error)
            print("Failed to save user")
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userID,forKey:PropertyKey.userID)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(email, forKey: PropertyKey.email)
        aCoder.encode(myItems, forKey: PropertyKey.myItems)
        aCoder.encode(borrowedItems, forKey: PropertyKey.borrowedItems)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let userID = aDecoder.decodeInteger(forKey: PropertyKey.userID)
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String
        let myItems = aDecoder.decodeObject(forKey: PropertyKey.myItems) as? [Item]
        let borrowedItems = aDecoder.decodeObject(forKey: PropertyKey.borrowedItems) as? [Item]
        
        self.init(userID: userID, name: name!, email:email!, myItems: myItems!, borrowedItems: borrowedItems!)
    }
    
    var userID:NSInteger
    var name:String
    //var photo:
    var email:String
    var myItems:[Item]
    var borrowedItems:[Item]
    
    init(userID:NSInteger,name:String,email:String,myItems:[Item],borrowedItems:[Item]){
        self.userID = userID
        self.name = name
        self.email = email
        self.myItems = myItems
        self.borrowedItems = borrowedItems
        super.init()
    }
}
