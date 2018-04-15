//
//  User.swift
//  Neighborly
//
//  Created by Other users on 4/14/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit
import SendBirdSDK

class User: SBDUser{
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
