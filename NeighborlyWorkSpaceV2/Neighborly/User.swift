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
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let userID = aDecoder.decodeInteger(forKey: PropertyKey.userID)
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String
        
        
        self.init(userID: userID, name: name!, email:email!)
    }
    
    var userID:NSInteger
    var name:String
    //var photo:
    var email:String

    
    init(userID:NSInteger,name:String,email:String){
        self.userID = userID
        self.name = name
        self.email = email
       
        super.init()
    }
}
